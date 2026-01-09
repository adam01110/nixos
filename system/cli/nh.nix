{vars, ...}:
# configure nh.
let
  inherit (vars) username;
in {
  programs.nh = {
    enable = true;

    # set flake root
    flake = "/home/${username}/Nixos";

    # enable automatic cleaning
    clean = {
      enable = true;
      extraArgs = "--keep-since 2d --keep 4";
    };
  };
}
