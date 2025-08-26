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
      {
        name = "fish-ssh-agent";
        src = pkgs.fetchFromGitHub {
          owner = "danhper";
          repo = "fish-ssh-agent";
          rev = "f10d95775352931796fd17f54e6bf2f910163d1b";
          sha256 = "sha256-cFroQ7PSBZ5BhXzZEKTKHnEAuEu8W9rFrGZAb8vTgIE=";
        };
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
  };
}
