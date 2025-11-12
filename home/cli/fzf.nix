{ ... }:

# configure fzf.
{
  programs.fzf = {
    enable = true;

    # change prompt default to look better.
    defaultOptions = [
      "--border rounded"
      "--prompt '➜ '"
    ];
  };
}
