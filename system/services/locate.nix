{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.locate = {
    enable = true;
    interval = "daily";
  };
}
