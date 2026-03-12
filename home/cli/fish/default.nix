{
  config,
  pkgs,
  ...
}:
# Configure fish shell.
{
  programs.fish = {
    enable = true;

    # Initialize interactive shell settings.
    interactiveShellInit = let
      editorName = config.home.sessionVariables.EDITOR;
    in ''
      set -U fifc_fd_opts --hidden
      set -U __done_min_cmd_duration 10000
      set -Ux fifc_editor ${editorName}

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
