{
  # keep-sorted start
  config,
  lib,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit (lib) getExe;
  inherit (pkgs) writeShellApplication;

  # keep-sorted start
  gh = getExe config.programs.gh.package;
  issueRef = "{strip_ansi|split:#:1|split:   :0}";
  # keep-sorted end
in {
  programs.television.channels.gh-issues = {
    # keep-sorted start block=yes newline_separated=yes
    actions = {
      # keep-sorted start block=yes newline_separated=yes
      close = {
        description = "Close the selected issue";
        command = "${gh} issue close ${issueRef}";
        mode = "fork";
      };

      comment = {
        description = "Add a comment to the selected issue";
        command = "${gh} issue comment ${issueRef}";
        mode = "execute";
      };

      open = {
        description = "Open the issue in the browser";
        command = "${gh} issue view ${issueRef} --web";
        mode = "fork";
      };
      # keep-sorted end
    };

    keybindings = {
      # keep-sorted start
      ctrl-c = "actions:close";
      ctrl-o = "actions:open";
      enter = "actions:comment";
      # keep-sorted end
    };

    metadata = {
      name = "gh-issues";
      description = "List GitHub issues for the current repo";
      requirements = [
        # keep-sorted start
        "gh"
        "jq"
        # keep-sorted end
      ];
    };

    preview.command = "${getExe (writeShellApplication {
      name = "tv-gh-issue-preview";
      runtimeInputs = [
        config.programs.gh.package
        pkgs.glow
      ];
      text = ''
        issue_ref="$1"

        ${gh} issue view "$issue_ref" --json title,number,state,author,createdAt,updatedAt,labels,assignees --jq '
          [
            "  " + .title,
            "  #" + (.number | tostring),
            "",
            "  \u001b[36mStatus:\u001b[39m \u001b[32m" + .state + "\u001b[39m",
            "  \u001b[36mAuthor:\u001b[39m \u001b[33m" + .author.login + "\u001b[39m",
            "  \u001b[36mCreated:\u001b[39m " + (.createdAt | fromdateiso8601 | (now - .) | if . < 3600 then (./60 | floor | tostring) + " minutes ago" elif . < 86400 then (./3600 | floor | tostring) + " hours ago" else (./86400 | floor | tostring) + " days ago" end),
            "  \u001b[36mUpdated:\u001b[39m " + (.updatedAt | fromdateiso8601 | (now - .) | if . < 3600 then (./60 | floor | tostring) + " minutes ago" elif . < 86400 then (./3600 | floor | tostring) + " hours ago" else (./86400 | floor | tostring) + " days ago" end),
            (if (.labels | length) > 0 then "  \u001b[36mLabels:\u001b[39m " + ([.labels[] | "\u001b[35m" + .name + "\u001b[39m"] | join(" ")) else "" end),
            (if (.assignees | length) > 0 then "  \u001b[36mAssignees:\u001b[39m " + ([.assignees[].login] | join(", ")) else "" end),
            "",
            "  \u001b[90m────────────────────────────────────────────────────────────\u001b[39m",
            ""
          ] | join("\n")
        '

        body=$(${gh} issue view "$issue_ref" --json body --jq '.body // ""')
        if [ -n "$body" ]; then
          printf '\n'
          printf '%s' "$body" | CLICOLOR_FORCE=1 glow -s dark -w 0 -
        fi
      '';
    })} '${issueRef}'";

    source = {
      # keep-sorted start
      ansi = true;
      command = "gh issue list --state open --limit 100 --json number,title,createdAt,author,labels | jq -r 'sort_by(.createdAt) | reverse | .[] | \"  \\u001b[32m#\\(.number)\\u001b[39m   \\(.title) \\u001b[33m@\\(.author.login)\\u001b[39m\" + (if (.labels | length) > 0 then \" \" + ([.labels[] | \"\\u001b[35m\" + .name + \"\\u001b[39m\"] | join(\" \")) else \"\" end)'\n";
      frecency = false;
      no_sort = true;
      output = issueRef;
      # keep-sorted end

    };

    ui.preview_panel.header = "#${issueRef}";
    # keep-sorted end
  };
}
