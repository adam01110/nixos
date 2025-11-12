{
  config,
  pkgs,
  ...
}:

# manage autostart desktop entries.
{
  xdg.autostart = {
    enable = true;
    readOnly = true;

    # start essential background apps on login.
    entries = [
      "${pkgs.bitwarden-desktop}/share/applications/bitwarden.desktop"
      "${config.programs.equinix.equibop.package}/share/applications/equibop.desktop"
      "${pkgs.nur.repos.ymstnt.beeper}/share/applications/beepertexts.desktop"
    ];
  };
}
