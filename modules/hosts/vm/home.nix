{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    # keep-sorted start block=yes newline_separated=yes
    # Configure the vm display settings.
    hyprland.monitors."Virtual-1" = {
      resolution = "1920x1080@60";
      position = "0x0";
      scale = 1;
      vrr = 0;
    };

    # Browser memory allocation for vm environment.
    zen-browser.commit-space = 6683;
    # keep-sorted end
  };
}
