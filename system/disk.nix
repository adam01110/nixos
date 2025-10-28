{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkOption
    types
    ;
in
{
  options.disko.selectedDisk = mkOption {
    type = types.str;
    example = "/dev/vda";
    description = "The disk device used by the system.";
  };

  config.disko.devices = {
    disk = {
      main = {
        type = "disk";
        device =
          let
            cfgDisk = config.disko.selectedDisk;
          in
          cfgDisk;
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

    nodev = {
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
