{
  config,
  lib,
  pkgs,
  ...
}:
# Configure fish shell.
let
  inherit (lib) escapeShellArgs;

  inherit
    (config.programs.eza)
    extraOptions
    icons
    ;
in {
  programs.fish = {
    enable = true;

    # Initialize interactive shell settings.
    interactiveShellInit = ''
      # Disable fish history.
      set -gx fish_history ""

      set -U __done_min_cmd_duration 10000

      set -U fzfish_popup true
      set -U fzfish_case_insensitive true
      set -U fzfish_show_hidden true
      set -U fzfish_rm_cmd trash-put

      set -U fzfish_bat_opts --style=numbers
      set -U fzfish_eza_opts ${escapeShellArgs (
        extraOptions
        ++ ["--icons=${icons}"]
      )}

      batman --export-env | source
    '';

    binds = {
      # Remove conflicting default bindings.
      "alt-e".erase = true;
      "alt-d".erase = true;
      "alt-l".erase = true;
    };
  };

  # Tools used by many things.
  home.packages = [pkgs.file];
}
