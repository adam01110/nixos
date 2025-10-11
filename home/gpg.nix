{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.gpg = {
    enable = true;

    homedir = "${config.xdg.dataHome}/gnupg";
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableFishIntegration = true;

    pinentry.program = pkgs.pinentry-gnome3;
  };
}
