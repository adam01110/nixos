{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfgZramTmp = config.tmp.type;
in
{
  zramSwap = {
    enable = true;
    algorithm = "zstd lz4 (type=huge)";
    priority = 100;
  };

  config = mkIf cfgZramTmp {
    boot.tmp = {
      useZram = true;
      zramSettings = {
        compression-algorithm = "zstd lz4 (type=huge)";
      };
    };
  };
}
