{
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) getExe';
in
{
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        source = ./logo.png;
        type = "kitty";
        height = 15;
        width = 35;
        padding = {
          top = 6;
        };
      };

      display = {
        separator = " ";
        size = {
          binaryPrefix = "jedec";
        };
      };

      modules = [
        "break"
        {
          type = "os";
          key = "{#7}  DISTRO ";
          keyColor = "blue";
          format = "\u001b[34m{#1}{#7} {3} ";
        }
        {
          type = "kernel";
          key = "│ ├ KERNEL";
          keyColor = "34";
          format = "{2}";
        }
        {
          type = "packages";
          key = "│ ├󰏖 PACKAGES";
          keyColor = "34";
        }
        {
          type = "shell";
          key = "│ ├ SHELL";
          keyColor = "34";
        }
        {
          type = "command";
          key = "│ ├󰅐 OS-AGE";
          keyColor = "34";
          text =
            let
              stat = getExe' pkgs.coreutils "stat";
              date = getExe' pkgs.coreutils "date";
            in
            ''
              birth_install=$(${stat} -c %W /)
              current=$(${date} +%s)
              time_progression=$((current - birth_install))
              days_difference=$((time_progression / 86400))
              echo $days_difference days
            '';
        }
        {
          type = "uptime";
          key = "│ ╰󰅐 UPTIME";
          keyColor = "34";
        }
        {
          type = "custom";
          format = "{#1}\u001b[34m╰─────────────────────────────────────────────────────────────";
        }
        {
          type = "wm";
          key = "{#7}  DE/WM ";
          keyColor = "36";
          format = "\u001b[36m{#1}{#7} {2} {3} ";
        }
        {
          type = "de";
          key = "│ ├󰧨 DE";
          keyColor = "cyan";
        }
        {
          type = "lm";
          key = "│ ├󰧨 LM";
          keyColor = "cyan";
        }
        {
          type = "wmtheme";
          key = "│ ├󰉼 THEME";
          keyColor = "cyan";
        }
        {
          type = "icons";
          key = "│ ├󰀻 ICONS";
          keyColor = "cyan";
        }
        {
          type = "terminal";
          key = "│ ├ TERMINAL";
          keyColor = "cyan";
        }
        {
          type = "terminalfont";
          key = "│ ╰ FONT";
          keyColor = "cyan";
        }
        {
          type = "custom";
          format = "{#1}\u001b[36m╰─────────────────────────────────────────────────────────────";
        }
        # "break"
        {
          type = "board";
          key = "{#7}  HARDWARE ";
          keyColor = "31";
          format = "\u001b[31m{#1}{#7} {1} ({2}) ";
        }
        {
          type = "cpu";
          key = "│ ├ CPU";
          keyColor = "red";
        }
        {
          type = "gpu";
          key = "│ ├󰍛 GPU";
          keyColor = "red";
          format = "{2} {3}";
        }
        {
          type = "memory";
          key = "│ ├󰑭 RAM";
          keyColor = "red";
          format = " {4} {1} / {2} ({3})";
        }
        {
          type = "btrfs";
          key = "│ ├ DISKS ";
          keyColor = "red";
          format = "{5} / {7} ({8}, {9} allocated) - {1}";
          folders = "/:/home";
        }
        {
          type = "disk";
          key = "│ ├ DISKS ";
          keyColor = "red";
          format = "{1} / {2} ({3}) - {10}";
          folders = "/run/media/dragonx/6b650fa5-44d8-430d-8960-71b48e25e15c";
        }
        {
          type = "disk";
          key = "│ ╰ EFI ";
          keyColor = "red";
          format = "{13} {1} / {2} ({3})";
          folders = "/boot/efi";
        }
        {
          type = "disk";
          key = "│ ├ BOOT";
          keyColor = "red";
          format = "{13} {1} / {2} ({3})";
          folders = "/boot";
        }
        {
          type = "custom";
          format = "{#1}\u001b[31m╰─────────────────────────────────────────────────────────────";
        }
        {
          type = "display";
          key = "{#7} 󰍹 DISPLAY ";
          keyColor = "38";
          format = "{#1}{#7}\u001b[32m {6} {1}x{2} @{3}Hz ({7}) ";
        }
        {
          type = "media";
          key = "│ ├󰝚  TRACK";
          keyColor = "38";
          format = "{3} - {1} ({5})";
        }
        {
          type = "sound";
          key = "│ ╰ VOLUME";
          keyColor = "38";
          format = "{#1}{5} ({#1}{3})";
        }
        {
          type = "custom";
          format = "{#1}\u001b[37m╰─────────────────────────────────────────────────────────────";
        }
        "break"
      ];
    };
  };
}
