{
  config,
  lib,
  pkgs,
  ...
}:

{
  zramSwap = {
    enable = true;
    algorithm = "zstd lz4 (type=huge)";
    priority = 100;
  };
}
