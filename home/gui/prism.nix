{
  pkgs,
  ...
}:

# configure prismlauncher.
{
  home.packages = with pkgs; [
    (prismlauncher.override {
      # disable uneeded support.
      controllerSupport = false;
      gamemodeSupport = false;
      textToSpeechSupport = false;

      # specifiy what java runtimes to install.
      jdks = [
        graalvmPackages.graalvm-ce
        jdk21
        jdk17
        jdk8
      ];
    })
  ];
}
