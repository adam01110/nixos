{
  # keep-sorted start
  config,
  lib,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit
    (lib)
    # keep-sorted start
    getExe
    getExe'
    # keep-sorted end
    ;
  inherit (pkgs) writeShellApplication;

  # keep-sorted start
  gh = getExe config.programs.gh.package;
  less = getExe' pkgs.less "less";
  prRef = "{strip_ansi|split:#:1|split:   :0}";
  # keep-sorted end
in {
  programs.television.channels.gh-prs = {
    # keep-sorted start block=yes newline_separated=yes
    actions = {
      # keep-sorted start block=yes newline_separated=yes
      checkout = {
        description = "Checkout the PR branch locally";
        command = "${gh} pr checkout ${prRef}";
        mode = "execute";
      };

      diff = {
        description = "View the PR diff";
        command = "${gh} pr diff ${prRef} | ${less}";
        mode = "execute";
      };

      merge = {
        description = "Merge the selected PR";
        command = "${gh} pr merge ${prRef}";
        mode = "execute";
      };

      open = {
        description = "Open the PR in the browser";
        command = "${gh} pr view ${prRef} --web";
        mode = "execute";
      };
      # keep-sorted end
    };

    keybindings = {
      # keep-sorted start
      ctrl-d = "actions:diff";
      ctrl-m = "actions:merge";
      ctrl-o = "actions:open";
      enter = "actions:checkout";
      # keep-sorted end
    };

    metadata = {
      name = "gh-prs";
      description = "List GitHub PRs for the current repo";
      requirements = [
        # keep-sorted start
        "gh"
        "jq"
        # keep-sorted end
      ];
    };

    preview.command = "${getExe (writeShellApplication {
      name = "tv-gh-pr-preview";
      runtimeInputs = [
        config.programs.gh.package
        pkgs.glow
      ];
      text = ''
        pr_ref="$1"

        ${gh} pr view "$pr_ref" --json title,number,state,baseRefName,headRefName,headRepositoryOwner,headRepository,author,createdAt,updatedAt,labels,mergeable,changedFiles,additions,deletions --jq '
          [
            "  " + .title,
            "  #" + (.number | tostring),
            "",
            "  \u001b[36mStatus:\u001b[39m \u001b[32m" + .state + "\u001b[39m  " + .baseRefName + " <- " + .headRefName,
            "  \u001b[36mRepo:\u001b[39m \u001b[34m" + (.headRepositoryOwner.login) + "/" + (.headRepository.name) + "\u001b[39m",
            "  \u001b[36mAuthor:\u001b[39m \u001b[33m" + .author.login + "\u001b[39m",
            "  \u001b[36mCreated:\u001b[39m " + (.createdAt | fromdateiso8601 | (now - .) | if . < 3600 then (./60 | floor | tostring) + " minutes ago" elif . < 86400 then (./3600 | floor | tostring) + " hours ago" else (./86400 | floor | tostring) + " days ago" end),
            "  \u001b[36mUpdated:\u001b[39m " + (.updatedAt | fromdateiso8601 | (now - .) | if . < 3600 then (./60 | floor | tostring) + " minutes ago" elif . < 86400 then (./3600 | floor | tostring) + " hours ago" else (./86400 | floor | tostring) + " days ago" end),
            (if (.labels | length) > 0 then "  \u001b[36mLabels:\u001b[39m " + ([.labels[] | "\u001b[35m" + .name + "\u001b[39m"] | join(" ")) else "" end),
            "  \u001b[36mMerge Status:\u001b[39m " + (if .mergeable == "MERGEABLE" then "\u001b[32mClean\u001b[39m" elif .mergeable == "CONFLICTING" then "\u001b[31mDirty\u001b[39m" else "\u001b[33mUnknown\u001b[39m" end),
            "  \u001b[36mChanges:\u001b[39m " + (.changedFiles | tostring) + " files  \u001b[32m+" + (.additions | tostring) + "\u001b[39m \u001b[31m-" + (.deletions | tostring) + "\u001b[39m",
            "",
            "  \u001b[90m────────────────────────────────────────────────────────────\u001b[39m",
            ""
          ] | join("\n")
        '

        body=$(${gh} pr view "$pr_ref" --json body --jq '.body // ""')
        if [ -n "$body" ]; then
          printf '\n'
          printf '%s' "$body" | CLICOLOR_FORCE=1 glow -s dark -w 0 -
        fi
      '';
    })} '${prRef}'";

    source = {
      # keep-sorted start
      ansi = true;
      command = "gh pr list --state open --limit 100 --json number,title,createdAt,author,labels | jq -r 'sort_by(.createdAt) | reverse | .[] | \"  \\u001b[32m#\\(.number)\\u001b[39m   \\(.title) \\u001b[33m@\\(.author.login)\\u001b[39m\" + (if (.labels | length) > 0 then \" \" + ([.labels[] | \"\\u001b[35m\" + .name + \"\\u001b[39m\"] | join(\" \")) else \"\" end)'\n";
      frecency = false;
      no_sort = true;
      output = prRef;
      # keep-sorted end
    };

    ui.preview_panel.header = "#${prRef}";
    # keep-sorted end
  };
}
