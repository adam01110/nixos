{ ... }:

# configure zoxide.
{
  programs.zoxide = {
    enable = true;

    # alias zoxide to just cd.
    options = [ "--cmd cd" ];
  };
}
