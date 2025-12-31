{
  inputs,
  ...
}:

{
  nix.settings = {
    # add binary caches.
    substituters = [
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
      "https://lanzaboote.cachix.org"
      "https://mic92.cachix.org"
      "https://numtide.cachix.org"
      "https://attic.xuyh0120.win/lantian"
    ];

    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "lanzaboote.cachix.org-1:Nt9//zGmqkg1k5iu+B3bkj3OmHKjSw9pvf3faffLLNk="
      "mic92.cachix.org-1:gi8IhgiT3CYZnJsaW7fxznzTkMUOn1RY4GmXdT/nXYQ="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];

    # enable modern commands and flakes.
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
  };

  # nixpkgs settings and overlays.
  nixpkgs = {
    config.allowUnfree = true;

    overlays = with inputs; [
      nix-cachyos-kernel.overlays.pinned
      zed-extensions.overlays.default
    ];
  };
}
