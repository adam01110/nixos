{
  config,
  lib,
  pkgs,
  ...
}:

{
  #environment.systemPackages = with pkgs; [ (lib.hiPrio pkgs.uutils-coreutils-noprefix) ];

  security = {
    sudo.enable = false;

    sudo-rs = {
      enable = true;
      execWheelOnly = true;
    };
  };
}
