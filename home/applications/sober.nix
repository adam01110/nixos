{
  config,
  lib,
  ...
}:

let
  inherit (lib) mkOption types;
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
      services.flatpak.packages = [ pkgName ];

      home.file.".var/app/${pkgName}/config/sober/config.json".text = builtins.toJSON {
        allow_gamepad_permission = false;
        bring_back_oof = false;
        close_on_leave = false;
        discord_rpc_enabled = true;
        enable_gamemode = false;
        enable_hidpi = false;
        fflags.DFIntTaskSchedulerTargetFps = targetFps;
        server_location_indicator_enabled = false;
        touch_mode = "off";
        use_libsecret = false;
        use_opengl = false;
      };
    };
}
