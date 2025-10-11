{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfgDisk = config.disko.selectedDisk;
  cfgZramTmp = config.tmp.type;
in
{
  options = {
    disko.selectedDisk = lib.mkOption {
      type = types.str;
      example = "/dev/vda";
      description = "The disk device used by the system.";
    };
    tmp.type = mkOption {
      type = types.enum [
        "tmpfs"
        "zram"
      ];
      default = "tmpfs";
      description = "Choose which temporary filesystem type to use for /tmp.";
    };
  };

  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = cfgDisk;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "256M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings.allowDiscards = true;
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "@" = {
                      mountpoint = "/";
                      mountOptions = [
                        "noatime"
                        "compress=zstd"
                        "space_cache=v2"
                        "commit=120"
                      ];
                    };
                    "@home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "noatime"
                        "compress=zstd"
                        "space_cache=v2"
                        "commit=120"
                      ];
                    };
                    "@root" = {
                      mountpoint = "/root";
                      mountOptions = [
                        "noatime"
                        "compress=zstd"
                        "space_cache=v2"
                        "commit=120"
                      ];
                    };
                    "@srv" = {
                      mountpoint = "/srv";
                      mountOptions = [
                        "noatime"
                        "compress=zstd"
                        "space_cache=v2"
                        "commit=120"
                      ];
                    };
                    "@cache" = {
                      mountpoint = "/var/cache";
                      mountOptions = [
                        "noatime"
                        "compress=zstd"
                        "space_cache=v2"
                        "commit=120"
                      ];
                    };
                    "@log" = {
                      mountpoint = "/var/log";
                      mountOptions = [
                        "noatime"
                        "compress=zstd"
                        "space_cache=v2"
                        "commit=120"
                      ];
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "noatime"
                        "compress=zstd"
                        "space_cache=v2"
                        "commit=120"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };

    nodev = mkIf (cfgZramTmp == "tmpfs") {
      "/tmp" = {
        fsType = "tmpfs";
        mountOptions = [
          "mode=1777"
          "noatime"
        ];
      };
    };
  };
}
