{...}:
# configure direnv for per-project environments.
{
  programs.direnv = {
    enable = true;

    # use nix-direnv for fast, cached shell hooks.
    nix-direnv.enable = true;
  };
}
