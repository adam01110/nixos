{
  inputs,
  ...
}:

{
  nix.settings = {
    trusted-substituters = [
      "https://cache.nixos.org/"
      "https://chaotic-nyx.cachix.org/"
    ];

    # enable nix flakes
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nixpkgs = {
    config.allowUnfree = true;

    overlays = with inputs; [
      #millennium.overlays.default
      dolphin-overlay.overlays.default
    ];
  };
}
