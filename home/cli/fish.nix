{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.fish = {
    enable = true;

    plugins = [
      {
        name = "done";
        src = pkgs.fishPlugins.done;
      }
      {
        name = "bang-bang";
        src = pkgs.fishPlugins.bang-bang;
      }
      {
        name = "fifc";
        src = pkgs.fishPlugins.fifc;
      }
    ];

    interactiveShellInit = ''
      set -U fifc_fd_opts --hidden
      set -U __done_min_cmd_duration 10000

      batman --export-env | source
    '';

    shellAbbrs.ff = "fastfetch";

    shellAliases = {
      wget = "wcurl";
      find = "fd";
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
      body = "fortune -s | boxes -d ansi-rounded";
    };

    home.packages = with pkgs; [
      fortune-kind
      boxes
    ];
  };
}
