{
  config,
  lib,
  ...
}:

# disk layout using disko.
let
  inherit (lib)
    mkOption
    types
    ;
in
{
  # host option: which block device to partition and install to.
  options.disko.selectedDisk = mkOption {
    type = types.str;
    example = "/dev/vda";
    description = "The disk device used by the system.";
  };

  # partitioning scheme and filesystem layout.
  config.disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = config.disko.selectedDisk;
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

                  # subvolume layout and common mount options.
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

    # tmpfs for /tmp
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
