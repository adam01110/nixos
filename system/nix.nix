{
  inputs,
  ...
}:

{

  # enable modern commands and flakes.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # nixpkgs settings and overlays.
  nixpkgs = {
    config.allowUnfree = true;

    overlays = with inputs; [
      millennium.overlays.default
      dolphin-overlay.overlays.default
      nix-cachyos-kernel.overlay
    ];
  };
}
