{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfgWifi = config.optServices.wifi.enable;
in
{
  options.optServices.wifi.enable = mkEnableOption "Enable wifi services.";

  services.resolved = {
    enable = true;
    dnsovertls = true;

    fallbackDns = [
      "1.1.1.1#cloudflare-dns.com"
      "1.0.0.1#cloudflare-dns.com"
      "2606:4700:4700::1111#cloudflare-dns.com"
      "2606:4700:4700::1001#cloudflare-dns.com"
    ];
  };

  systemd.network.wait-online.enable = false;

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

    nameservers = [
      # TODO
      "8.8.8.8"
      "8.8.4.4"
    ];
  };
}
