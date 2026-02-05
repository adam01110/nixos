{
  config,
  lib,
  pkgs,
  ...
}:
# Configure fish shell.
let
  inherit
    (lib)
    getExe
    getExe'
    ;
in {
  programs.fish = {
    enable = true;

    # Enable plugins.
    plugins = let
      mkPlugin = pkg: {
        name = "${pkg}";
        inherit (pkgs.fishPlugins.${pkg}) src;
      };
    in
      map mkPlugin [
        "autopair"
        "done"
        "fishbang"
        "fifc"
      ];

    # Initialize interactive shell settings.
    interactiveShellInit = let
      editorName = config.home.sessionVariables.EDITOR;
    in ''
      set -U fifc_fd_opts --hidden
      set -U __done_min_cmd_duration 10000
      set -Ux fifc_editor ${editorName}

      batman --export-env | source
    '';

    # Add shorthand abbreviation.
    shellAbbrs = {
      ff = "fastfetch";
      gf = "gitfetch";
      oc = "opencode";
    };

    # Override commands with preferred tools.
    shellAliases = let
      ripgrep = getExe pkgs.ripgrep;
    in {
      wget = getExe' pkgs.curl "wcurl";
      cat = getExe pkgs.bat;
      grep = ripgrep;
      egrep = ripgrep;
      fgrep = "${ripgrep} -F";

      speedtest = getExe pkgs.speedtest-go;

      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      "......" = "cd ../../../../..";
      "......." = "cd ../../../../../..";
    };

    binds = {
      # Remove conflicting default bindings.
      "alt-e".erase = true;
      "alt-d".erase = true;
    };
  };
}
