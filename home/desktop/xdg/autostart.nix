{
  config,
  pkgs,
  ...
}:
# Manage autostart desktop entries.
{
  xdg.autostart = {
    enable = true;

    # Start essential background apps on login.
    entries = [
      "${config.programs.nixcord.equibop.package}/share/applications/equibop.desktop"
      "${pkgs.nur.repos.forkprince.beeper-nightly}/share/applications/beepertexts.desktop"
    ];
  };
}
