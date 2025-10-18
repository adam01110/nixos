{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfgWifi = config.optServices.wifi.enable;

  hostname = config.networking.hostName;

  dnsNameserver1 = config.sops.secrets."dns/${hostname}/dns_1";
  dnsNameserver2 = config.sops.secrets."dns/${hostname}/dns_2";
  dnsNameserver3 = config.sops.secrets."dns/${hostname}/dns_3";
  dnsNameserver4 = config.sops.secrets."dns/${hostname}/dns_4";
in
{
  sops.secrets = {
    "dns/${hostname}/dns_1" = { };
    "dns/${hostname}/dns_2" = { };
    "dns/${hostname}/dns_3" = { };
    "dns/${hostname}/dns_4" = { };
  };

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
      dnsNameserver1
      dnsNameserver2
      dnsNameserver3
      dnsNameserver4
    ];
  };
}
