_:
# Configure fzf.
{
  programs.fzf = {
    enable = true;

    # Change prompt default to look better.
    defaultOptions = [
      "--border sharp"
      "--prompt '➜ '"
    ];
  };
}
