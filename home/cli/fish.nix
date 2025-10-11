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

      set -x MANROFFOPT "-c"
      set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
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

    functions = {
      # TODO: greet
    };

    home.packages = with pkgs; [
      fortune-kind
      boxes
    ];
  };
}
