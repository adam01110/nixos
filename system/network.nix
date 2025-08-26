{
  config,
  lib,
  pkgs,
  username,
  ...
}:

with lib;
let
  systemHostName = config.networking.hostName;
  cfgNetworkType = config.networking.type;
  cfgNetworkInterface = config.networking.interface;
  dhcpHostname = "${username}-${systemHostName}";
in
{
  options = {
    networking = {
      type = mkOption {
        type = types.enum [
          "networkd"
          "networkmanager"
        ];
        default = "networkd";
        description = "What networking implementation to use.";
      };

      interface = mkOption {
        type = types.str;
        description = "What network interface to use for networkd.";
      };
    };
  };

  config = {
    services.resolved.enable = true;
    networking.resolvconf.enable = false;
    networking.useDHCP = mkForce false;

    systemd.network = mkIf (cfgNetworkType == "networkd") {
      enable = true;
      networks."10-${cfgNetworkInterface}" = {
        matchConfig.Name = cfgNetworkInterface;
        networkConfig.DHCP = "yes";
        dhcpConfig = {
          SendHostname = true;
          Hostname = dhcpHostname;
        };
      };

      links."10-random-mac-${cfgNetworkInterface}" = {
        matchConfig.Name = cfgNetworkInterface;
        linkConfig.MACAddressPolicy = "random";
      };
    };

    networking.networkmanager = mkIf (cfgNetworkType == "networkmanager") {
      enable = true;
      dns = "systemd-resolved";
      wifi.scanRandMacAddress = true;
    };
  };
}
