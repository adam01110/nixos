{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (builtins) attrValues;
  inherit (lib) getExe;
in
{
  programs.fish = {
    enable = true;

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

    shellAbbrs.ff = "fastfetch";

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

    functions.fish_greeting = {
      body =
        let
          fortune-kind = getExe pkgs.fortune-kind;
          boxes = getExe pkgs.boxes;
        in
        "${fortune-kind} -s | ${boxes} -d ansi-rounded";
    };
  };

  home.packages = attrValues {
    inherit (pkgs)
      fortune-kind
      boxes
      ;
  };
}
