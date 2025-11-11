{
  inputs,
  ...
}:

{
  nix.settings = {
    # core nix substituters.
    substituters = [
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
      "https://chaotic-nyx.cachix.org/"
      "https://lanzaboote.cachix.org"
      "https://mic92.cachix.org"
      "https://numtide.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8"
      "lanzaboote.cachix.org-1:Nt9//zGmqkg1k5iu+B3bkj3OmHKjSw9pvf3faffLLNk="
      "mic92.cachix.org-1:gi8IhgiT3CYZnJsaW7fxznzTkMUOn1RY4GmXdT/nXYQ="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    ];

    # enable modern commands and flakes.
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # nixpkgs settings and overlays.
  nixpkgs = {
    config.allowUnfree = true;

    overlays = with inputs; [
      millennium.overlays.default
      dolphin-overlay.overlays.default
    ];
  };
}
