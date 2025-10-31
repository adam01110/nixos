{
  config,
  lib,
  pkgs,
  username,
  ...
}:

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
          enableWifi = config.optServices.wifi.enable;
          enableCDMA = false;
          enableModemGPS = false;
          enable3G = false;
          enableNmea = false;
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
              "geoclue2_static/${hostname}/longitude" = { };
              "geoclue2_static/${hostname}/latitude" = { };
              "geoclue2_static/${hostname}/altitude" = { };
            };

            templates."geoclue-static".content = ''
              ${config.sops.placeholder."geoclue2_static/${hostname}/latitude"}
              ${config.sops.placeholder."geoclue2_static/${hostname}/longitude"}
              ${config.sops.placeholder."geoclue2_static/${hostname}/altitude"}
              0
            '';
          };

        environment.etc.geolocation = mkForce {
          source = config.sops.templates."geoclue-static".path;
          mode = "0440";
          group = "geoclue";
        };
      })
    ];
}
