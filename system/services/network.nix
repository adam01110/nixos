{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfgWifi = config.optServices.wifi.enable;
  hostname = config.networking.hostName;
in
{
  options.optServices.wifi.enable = mkEnableOption "Enable wifi services.";

  config = {
    sops = {
      secrets = {
        "dns/${hostname}/dns_1" = { };
        "dns/${hostname}/dns_2" = { };
        "dns/${hostname}/dns_3" = { };
        "dns/${hostname}/dns_4" = { };
      };

      templates."resolved-dns.conf".content = ''
        [Resolve]
        DNS=${config.sops.placeholder."dns/${hostname}/dns_1"}
        DNS=${config.sops.placeholder."dns/${hostname}/dns_2"}
        DNS=${config.sops.placeholder."dns/${hostname}/dns_3"}
        DNS=${config.sops.placeholder."dns/${hostname}/dns_4"}
      '';
    };

    services.resolved = {
      enable = true;
      dnsovertls = "true";

      fallbackDns = [
        "1.1.1.1#cloudflare-dns.com"
        "1.0.0.1#cloudflare-dns.com"
        "2606:4700:4700::1111#cloudflare-dns.com"
        "2606:4700:4700::1001#cloudflare-dns.com"
      ];
    };

    systemd = {
      network.wait-online.enable = false;

      services.systemd-resolved = {
        wants = [ "sops-nix.service" ];
        after = [ "sops-nix.service" ];
      };
    };

    environment.etc."systemd/resolved.conf.d/00-dns.conf".source =
      config.sops.templates."resolved-dns.conf".path;

    networking = {
      useDHCP = false;
      dhcpcd.enable = false;

      wireless.iwd.enable = cfgWifi;

      networkmanager = {
        enable = true;
        dns = "systemd-resolved";
        wifi = mkIf cfgWifi {
          backend = "iwd";
          scanRandMacAddress = true;
        };
      };
    };
  };
}
