{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        type = "kitty-direct";
        source = "./logo.png";
        height = 20;
        width = 20;
      };

      display.separator = " ";

      modules = [
        "title"
        {
          type = "custom";
          format = "────────────";
        }
        {
          type = "os";
          key = " OS";
        }
        {
          type = "kernel";
          key = "├";
        }
        {
          type = "packages";
          key = "├";
        }
        {
          type = "shell";
          key = "╰";
        }
        {
          type = "separator";
          "string" = "  ";
        }
        {
          type = "wm";
          key = " WM";
        }
        {
          type = "theme";
          key = "├";
        }
        {
          type = "font";
          key = "├";
        }
        {
          type = "icons";
          key = "├";
        }
        {
          type = "terminal";
          key = "╰";
        }
        {
          type = "separator";
          string = "  ";
        }
        {
          type = "board";
          key = " PC";
        }
        {
          type = "cpu";
          key = "├";
        }
        {
          type = "gpu";
          key = "├";
        }
        {
          type = "disk";
          key = "├";
        }
        {
          type = "memory";
          key = "├";
        }
        {
          type = "swap";
          key = "╰";
        }
        {
          type = "separator";
          string = "  ";
        }
        {
          type = "custom";
          format = " \u001B[38m●  \u001B[37m●  \u001B[36m●  \u001B[35m●  \u001B[34m●  \u001B[33m●  \u001B[32m●  \u001B[31m●";
        }
      ];
    };
  };
}
