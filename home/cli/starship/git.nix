_:
# detailed git and fossil status sections.
{
  programs.starship.settings = {
    fossil_branch = {
      format = "[$symbol$branch]($style) ";
      symbol = " ";
      style = "fg:magenta bold";
    };

    git_branch = {
      format = "[$symbol$branch(:$remote_branch)]($style)";
      symbol = " ";
      style = "bg:base01 fg:magenta bold";
    };

    git_commit = {
      format = "[\\($hash$tag\\)]($style)";
      style = "bg:base01 fg:green bold";
      tag_disabled = false;
      only_detached = false;
      tag_symbol = "  ";
    };

    git_state = {
      format = "[ $state( $progress_current/$progress_total)]($style)";
      style = "bg:base01 fg:yellow bold";
      rebase = "rebasing";
      merge = "merging";
      revert = "reverting";
      cherry_pick = "cherry-picking";
      bisect = "bisecting";
      am = "am";
      am_or_rebase = "am/rebase";
    };

    git_status = {
      format = "([ \\[$all_status$ahead_behind\\]]($style))";
      style = "bg:base01 fg:base08 bold";
      deleted = "";
    };
  };
}
