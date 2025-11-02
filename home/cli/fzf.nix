{ ... }:

{
  programs.fzf = {
    enable = true;

    defaultOptions = [
      "--border rounded"
      "--prompt '➜ '"
    ];
  };
}
