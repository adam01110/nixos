{
  config,
  inputs,
  ...
}: {
  sops = {
    secrets."nix_access_tokens/github" = {};
    templates.access_tokens.content = ''access-tokens = github.com=${config.sops.placeholder."nix_access_tokens/github"}'';
  };

  nix = {
    settings = {
      # add binary caches.
      substituters = [
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://lanzaboote.cachix.org"
        "https://mic92.cachix.org"
        "https://numtide.cachix.org"
        "https://attic.xuyh0120.win/lantian"
        "https://cache.numtide.com"
      ];

      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "lanzaboote.cachix.org-1:Nt9//zGmqkg1k5iu+B3bkj3OmHKjSw9pvf3faffLLNk="
        "mic92.cachix.org-1:gi8IhgiT3CYZnJsaW7fxznzTkMUOn1RY4GmXdT/nXYQ="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      ];

      # enable modern commands and flakes.
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
    };

    extraOptions = ''!include ${config.sops.templates."access_tokens".path}'';
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
