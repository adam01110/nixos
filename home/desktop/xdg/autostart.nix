{
  config,
  pkgs,
  ...
}:
# manage autostart desktop entries.
{
  xdg.autostart = {
    enable = true;

    # start essential background apps on login.
    entries = [
      "${config.programs.nixcord.equibop.package}/share/applications/equibop.desktop"
      "${pkgs.nur.repos.ymstnt.beeper}/share/applications/beepertexts.desktop"
    ];
  };
}
