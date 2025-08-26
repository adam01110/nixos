{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfgPrinting = config.optServices.printing.enable;
  cfgBluetooth = config.optServices.bluetooth.enable;
  cfgSsh = config.optServices.ssh.enable;
  cfgFwupd = config.optServices.fwupd.enable;
  cfgZramTmp = config.tmp.type;
in
{
  options.optServices = {
    printing.enable = mkEnableOption "Enable printing services.";
    bluetooth.enable = mkEnableOption "Enable bluetooth services.";
    ssh.enable = mkEnableOption "Enable Ssh services.";
    fwupd.enable = mkEnableOption "Enable firmware update services.";
  };

  config = mkMerge [
    {
      services = {
        libinput.enable = true;
        fstrim.enable = true;
        gvfs.enable = true;
        flatpak.enable = true;

        pipewire = {
          enable = true;
          wireplumber.enable = true;
          pulse.enable = true;
          jack.enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
        };

        ananicy = {
          enable = true;
          package = pkgs.ananicy-cpp;
          rulesProvider = pkgs.ananicy-rules-cachyos_git;
        };
      };

      zramSwap = {
        enable = true;
        algorithm = "zstd lz4 (type=huge)";
        priority = 100;
      };
    }

    (mkIf cfgPrinting {
      services.printing = {
        enable = true;
        openFirewall = true;
      };
    })

    (mkIf cfgBluetooth {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings.General.Experimental = true;
      };
    })

    (mkIf cfgSsh {
      services.openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = true;
        };
      };
    })

    (mkIf cfgFwupd {
      services.fwupd.enable = true;
    })

    (mkIf (cfgZramTmp == "zram") {
      boot.tmp = {
        useZram = true;
        zramSettings = {
          compression-algorithm = "zstd lz4 (type=huge)";
        };
      };
    })
  ];
}
