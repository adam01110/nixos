{
  config,
  lib,
  ...
}:

# geoclue2 service with optional "static" location provider.
let
  inherit (lib)
    mkEnableOption
    mkForce
    mkIf
    mkMerge
    ;
in
{
  options.optServices.geoclue2.static = {
    enable = mkEnableOption "Enable geoclue2 static location services";
  };

  config =
    let
      cfg = config.optServices.geoclue2.static;
    in
    mkMerge [
      {
        services.geoclue2 = {
          enable = true;

          # use wi‑fi positioning only when wi‑fi is enabled in the system.
          enableWifi = config.optServices.wifi.enable;

          # disable radio/serial backends to avoid unnecessary hardware usage.
          enableCDMA = false;
          enableModemGPS = false;
          enable3G = false;
          enableNmea = false;

          # optionally turn on the staa
          enableStatic = cfg.enable;
        };
      }

      (mkIf cfg.enable {
        sops =
          let
            hostname = config.networking.hostName;
          in
          {
            secrets = {
              # per‑host secret values holding the coordinates.
              "geoclue2_static/${hostname}/longitude" = { };
              "geoclue2_static/${hostname}/latitude" = { };
              "geoclue2_static/${hostname}/altitude" = { };
            };

            # build the /etc/geolocation content expected by geoclue’s static
            # provider: latitude, longitude, altitude, accuracy (meters).
            templates."geoclue-static".content = ''
              ${config.sops.placeholder."geoclue2_static/${hostname}/latitude"}
              ${config.sops.placeholder."geoclue2_static/${hostname}/longitude"}
              ${config.sops.placeholder."geoclue2_static/${hostname}/altitude"}
              0
            '';
          };

        # install the generated file.
        environment.etc.geolocation = mkForce {
          source = config.sops.templates."geoclue-static".path;
          mode = "0440";
          group = "geoclue";
        };
      })
    ];
}
