{
  config,
  lib,
  vars,
  ...
}:
# networking: resolved + networkmanager, optional wi‑fi via iwd.
let
  inherit
    (lib)
    mkEnableOption
    mkIf
    ;
  inherit (vars) username;
in {
  options.optServices.wifi.enable = mkEnableOption "Enable wifi services.";

  config = {
    users.users.${username}.extraGroups = ["networkmanager"];

    sops = let
      hostname = config.networking.hostName;
    in {
      secrets = {
        "dns/${hostname}/dns_1" = {};
        "dns/${hostname}/dns_2" = {};
        "dns/${hostname}/dns_3" = {};
        "dns/${hostname}/dns_4" = {};
      };

      # template for resolved.conf carrying dns servers from sops.
      templates."resolved-dns.conf" = {
        # allow systemd-resolved to read the rendered dns drop-in.
        mode = "0440";
        group = "systemd-resolve";

        content = ''
          [Resolve]
          DNS=${config.sops.placeholder."dns/${hostname}/dns_1"} ${config.sops.placeholder."dns/${hostname}/dns_2"} ${config.sops.placeholder."dns/${hostname}/dns_3"} ${config.sops.placeholder."dns/${hostname}/dns_4"}
        '';
      };
    };

    services.resolved = {
      enable = true;
      settings.Resolve = {
        DNSOverTLS = "opportunistic";

        FallbackDNS = [
          "1.1.1.1#cloudflare-dns.com"
          "1.0.0.1#cloudflare-dns.com"
          "2606:4700:4700::1111#cloudflare-dns.com"
          "2606:4700:4700::1001#cloudflare-dns.com"
        ];
      };
    };

    systemd = {
      # avoid blocking boot on network readiness.
      network.wait-online.enable = false;

      services.systemd-resolved = {
        wants = ["sops-nix.service"];
        after = ["sops-nix.service"];
      };
    };

    # install the resolved dns drop-in rendered from sops.
    environment.etc."systemd/resolved.conf.d/00-dns.conf".source =
      config.sops.templates."resolved-dns.conf".path;

    # networkmanager with iwd wi‑fi backend when enabled.
    networking = let
      cfgWifi = config.optServices.wifi.enable;
    in {
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
