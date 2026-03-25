_:
# Configure direnv for per-project environments.
{
  programs.direnv = {
    enable = true;

    # Use nix-direnv for fast, cached shell hooks.
    nix-direnv.enable = true;
  };
}
