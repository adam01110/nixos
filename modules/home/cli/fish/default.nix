{
  # keep-sorted start
  config,
  lib,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit (lib) escapeShellArgs;

  inherit
    (config.programs.eza)
    # keep-sorted start
    extraOptions
    icons
    # keep-sorted end
    ;
in {
  # keep-sorted start block=yes newline_separated=yes
  # Tools used by many things.
  home.packages = [pkgs.file];

  programs.fish = {
    enable = true;

    # Initialize interactive shell settings.
    interactiveShellInit = ''
      # Disable fish history.
      set -gx fish_history ""

      # Set the completed command notification to 10s.
      set -U __done_min_cmd_duration 10000

      # Tune fzfish defaults to match the preferred preview and delete tools.
      # keep-sorted start
      set -U fzfish_case_insensitive true
      set -U fzfish_popup true
      set -U fzfish_rm_cmd trash-put
      set -U fzfish_show_hidden true
      # keep-sorted end

      set -U fzfish_bat_opts --style=numbers
      set -U fzfish_eza_opts ${escapeShellArgs (
        extraOptions
        ++ ["--icons=${icons}"]
      )}

      # Reuse bat's pager environment inside fish sessions.
      batman --export-env | source
    '';

    binds = {
      # Remove conflicting default bindings.
      # keep-sorted start
      "alt-d".erase = true;
      "alt-e".erase = true;
      "alt-l".erase = true;
      # keep-sorted end
    };
  };
  # keep-sorted end
}
