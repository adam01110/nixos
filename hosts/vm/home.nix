{vars, ...}:
# per-host home manager overrides for qemu/kvm virtual machines.
let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    # configure the vm display settings.
    hyprland.monitors."Virtual-1" = {
      resolution = "1920x1080@60";
      position = "0x0";
      scale = 1;
      vrr = 0;
    };

    # browser memory allocation for vm environment.
    zen-browser.commit-space = 6683;

    # enable the use of emulated gpus in zed.
    zed.isVm = true;
  };
}
