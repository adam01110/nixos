{
  config,
  lib,
  pkgs,
  ...
}:

# configure sober flatpak.
let
  inherit (lib) mkOption types;
  jsonFormat = pkgs.formats.json { };
in
{
  options.sober.fps = mkOption {
    type = types.int;
    default = 60;
    description = "Target frames per second.";
  };

  config =
    let
      pkgName = "org.vinegarhq.Sober";
      targetFps = config.sober.fps;
    in
    {
      # add flatpak packge.
      services.flatpak.packages = [ pkgName ];

      # write sober config.
      home.file.".var/app/${pkgName}/config/sober/config.json".source =
        jsonFormat.generate "sober-config.json"
          {
            allow_gamepad_permission = false;
            close_on_leave = false;
            discord_rpc_enabled = true;
            enable_gamemode = false;
            enable_hidpi = false;
            fflags.DFIntTaskSchedulerTargetFps = targetFps;
            server_location_indicator_enabled = false;
            touch_mode = "off";
            use_libsecret = true;
            use_opengl = false;
          };
    };
}
