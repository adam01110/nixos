{ ... }:

# configure GNU parallel for CLI sessions.
{
  programs.parallel = {
    enable = true;

    # do not install the package.
    package = null;

    # set citation acknowledgement to avoid startup prompt.
    will-cite = true;
  };
}
