{
  config,
  inputs,
  lib,
  ...
}: {
  sops = {
    secrets."nix_access_tokens/github" = {};
    templates.access_tokens.content = ''access-tokens = github.com=${config.sops.placeholder."nix_access_tokens/github"}'';
  };

  nix = {
    settings = {
      # Add binary caches.
      substituters = [
        "https://nix-community.cachix.org"
        "https://lanzaboote.cachix.org"
        "https://mic92.cachix.org"
        "https://numtide.cachix.org"
        "https://attic.xuyh0120.win/lantian"
        "https://cache.numtide.com"
        "https://adam01110-nur.cachix.org/"
        "https://forkprince.cachix.org/"
        "https://ymstnt-nur-packages.cachix.org/"
        "https://nur-xyenon.cachix.org/"
        "https://nvf.cachix.org/"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "lanzaboote.cachix.org-1:Nt9//zGmqkg1k5iu+B3bkj3OmHKjSw9pvf3faffLLNk="
        "mic92.cachix.org-1:gi8IhgiT3CYZnJsaW7fxznzTkMUOn1RY4GmXdT/nXYQ="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        "adam01110-nur.cachix.org-1:43B8awTREG19aQ20luDD9BkxijKG/Q7hf8voMzS1X9I="
        "forkprince.cachix.org-1:9cN+fX492ZKlfd228xpYAC3T9gNKwS1sZvCqH8iAy1M="
        "ymstnt-nur-packages.cachix.org-1:6XI6/GtEZmGUEYQsK5gUBrEMGTSnAN6xq8Vg++DA/lc="
        "nur-xyenon.cachix.org-1:fZ3SGJ3E1p34JSG5j4etfF9+vjJGMZxe1dDBNliKx5U="
        "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
      ];

      # Enable modern commands and flakes.
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];

      # Enable determinate nix features.
      lazy-trees = true;
      eval-cores = 0;
    };

    extraOptions = ''!include ${config.sops.templates."access_tokens".path}'';
  };

  # Nixpkgs settings and overlays.
  nixpkgs = {
    config.allowUnfree = true;

    overlays = import ../overlays {inherit inputs lib;};
  };
}
