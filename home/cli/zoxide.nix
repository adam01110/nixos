_:
# Configure zoxide.
{
  programs.zoxide = {
    enable = true;

    # Alias zoxide to just cd.
    options = ["--cmd cd"];
  };
}
