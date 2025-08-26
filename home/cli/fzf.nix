{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.fzf = {
    enable = true;

    defaultOptions = [
      "--border rounded"
      "--prompt '➜ '"
    ];
  };
}
