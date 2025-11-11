{ ... }:

{
  # uutils-coreutils-noprefix: rust replacement for gnu coreutils.
  # environment.systemPackages = with pkgs; [ (lib.hiPrio pkgs.uutils-coreutils-noprefix) ];

  # rewrite of sudo in rust; enabled and limited to wheel
  security = {
    sudo.enable = false;

    sudo-rs = {
      enable = true;
      execWheelOnly = true;
    };
  };
}
