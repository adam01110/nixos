_:
# configure nix-your-shell prompts and monitoring.
{
  programs.nix-your-shell = {
    enable = true;

    # show build progress with nom.
    nix-output-monitor.enable = true;
  };
}
