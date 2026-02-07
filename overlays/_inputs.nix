{inputs}:
# Upstream overlay inputs used by this config.
with inputs; [
  nix-cachyos-kernel.overlays.pinned
  neovim-nightly-overlay.overlays.default
  zed-extensions.overlays.default
  millennium.overlays.default
]
