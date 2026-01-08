{
  config,
  lib,
  pkgs,
  ...
}:

# configure fish shell.
let
  inherit (lib)
    getExe
    getExe'
    ;
in
{
  imports = [
    ./functions.nix
    ./packages.nix
  ];

  programs.fish = {
    enable = true;

    # enable plugins.
    plugins =
      let
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

    # initialize interactive shell settings.
    interactiveShellInit =
      let
        editorName = config.home.sessionVariables.EDITOR;
      in
      ''
        set -U fifc_fd_opts --hidden
        set -U __done_min_cmd_duration 10000
        set -Ux fifc_editor ${editorName}

        batman --export-env | source
      '';

    # add shorthand abbreviation.
    shellAbbrs = {
      ff = "fastfetch";
      gf = "gitfetch";
    };

    # override commands with preferred tools.
    shellAliases =
      let
        ripgrep = getExe pkgs.ripgrep;
      in
      {
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
      "alt-e".erase = true;
      "alt-d".erase = true;
    };
  };
}
