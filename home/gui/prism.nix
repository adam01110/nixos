{pkgs, ...}:
# Configure prismlauncher.
{
  home.packages = with pkgs; [
    (prismlauncher.override {
      # Disable uneeded support.
      controllerSupport = false;
      gamemodeSupport = false;
      textToSpeechSupport = false;

      # Specifiy what java runtimes to install.
      jdks = [
        graalvmPackages.graalvm-ce
        jdk21
        jdk17
        jdk8
      ];
    })
  ];
}
