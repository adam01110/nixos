{
  config,
  lib,
  pkgs,
  ...
}:

{
  xdg.autostart = {
    enable = true;
    readOnly = true;

    entries = [
      "${pkgs.bitwarden-desktop}/share/applications/bitwarden.desktop"
      "${pkgs.equibop}/share/applications/equibop.desktop"
      "${pkgs.nur.repos.ymstnt.beeper}/share/applications/beepertexts.desktop"
    ];
  };
}
