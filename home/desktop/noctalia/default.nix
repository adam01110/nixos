{
  lib,
  inputs,
  pkgs,
  system,
  ...
}: {
  # pull in per-feature Noctalia modules.
  imports = [
    ./audio.nix
    ./bar.nix
    ./brightness.nix
    ./calendar.nix
    ./controlcenter.nix
    ./dock.nix
    ./general.nix
    ./hooks.nix
    ./launcher.nix
    ./location.nix
    ./network.nix
    ./notifications.nix
    ./plugins.nix
    ./sessionmenu.nix
    ./systemmonitor.nix
    ./ui.nix
    ./wallpaper.nix
  ];

  # expose an enable toggle for battery widgets.
  options.noctalia.battery.enable = lib.mkEnableOption "Enable the battery service & widgets.";

  # enable the Noctalia shell and wire up its package.
  config = let
    agentPackage = inputs.noctalia-auth-agent.packages.${system}.noctalia-polkit;
  in {
    programs.noctalia-shell = {
      enable = true;
      systemd.enable = true;

      # enable calendar support in the flake-provided Noctalia build.
      package = inputs.noctalia.packages.${system}.default.override {
        calendarSupport = true;
      };

      # keep template generation under explicit control.
      settings.colorschemes.generateTemplatesForPredefined = false;
    };

    home.packages = [agentPackage];

    # wire up the polkit auth agent user service.
    systemd.user.services.noctalia-polkit = {
      Unit = {
        Description = "Noctalia Polkit Authentication Agent";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session.target"];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };

      Service = {
        ExecStartPre = let
          keyringPrompter = "${agentPackage}/share/noctalia-polkit/org.gnome.keyring.SystemPrompter.service";
        in "${pkgs.runtimeShell} -c 'mkdir -p \"\${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services\" && cp -n ${keyringPrompter} \"\${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services/\"'";
        ExecStart = "${agentPackage}/libexec/noctalia-polkit";
        Slice = "session.slice";
        TimeoutStopSec = "5s";
        Restart = "on-failure";
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
