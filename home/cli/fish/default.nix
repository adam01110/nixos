{pkgs, ...}:
# Configure fish shell.
{
  programs.fish = {
    enable = true;

    # Initialize interactive shell settings.
    interactiveShellInit = ''
      set -U __done_min_cmd_duration 10000

      set -U fzfish_popup true
      set -U fzfish_case_insensitive true
      set -U fzfish_show_hidden true
      set -U fzfish_bat_opts --style=numbers
      set -U fzfish_rm_cmd trash-put

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
