{ ... }:

{
  # miscellaneous cli helpers shared across hosts.
  programs = {
    # allow per-project shell environments via direnv.
    direnv.enable = true;
  };
}
