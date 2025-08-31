{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    (prismlauncher.override {
      controllerSupport = false;
      gamemodeSupport = false;
      textToSpeechSupport = false;
    })
  ];
}
