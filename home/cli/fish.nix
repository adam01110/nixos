{
  config,
  lib,
  pkgs,
  ...
}:

# configure fish shell.
let
  inherit (builtins) attrValues;
  inherit (lib) getExe;
in
{
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

    # add shorthand fastfetch abbreviation.
    shellAbbrs.ff = "fastfetch";

    # override commands with preferred tools.
    shellAliases = {
      wget = "wcurl";
      cat = "bat";
      grep = "rg";
      egrep = "rg";
      fgrep = "rg -F";

      speedtest = "speedtest-go";

      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      "......" = "cd ../../../../..";
      "......." = "cd ../../../../../..";
    };

    # display a fortune in a box on shell start.
    functions.fish_greeting = {
      body =
        let
          fortune-kind = getExe pkgs.fortune-kind;
          boxes = getExe pkgs.boxes;
        in
        "${fortune-kind} -s | ${boxes} -d ansi-rounded";
    };
  };

  # tools needed by the fish greeting.
  home.packages = attrValues {
    inherit (pkgs)
      fortune-kind
      boxes
      ;
  };
}
