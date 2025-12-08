{ ... }:

{
  # miscellaneous cli helpers shared across hosts.
  programs = {
    # allow per-project shell environments via direnv.
    direnv.enable = true;

    # show per-process bandwidth usage from the tui.
    bandwhich.enable = true;
  };
}
