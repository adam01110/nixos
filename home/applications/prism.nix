{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = [
    (pkgs.prismlauncher.override {
      controllerSupport = false;
      gamemodeSupport = false;
      textToSpeechSupport = false;
    })
  ];
}
