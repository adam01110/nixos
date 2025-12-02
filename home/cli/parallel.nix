{ ... }:

# configure GNU parallel for CLI sessions.
{
  programs.parallel = {
    enable = true;

    # set citation acknowledgement to avoid startup prompt.
    will-cite = true;
  };
}
