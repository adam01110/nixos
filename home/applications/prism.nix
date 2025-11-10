{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    (pkgs.prismlauncher.override {
      controllerSupport = false;
      gamemodeSupport = false;
      textToSpeechSupport = false;

      jdks = [
        graalvmPackages.graalvm-ce
        jdk21
        jdk17
        jdk8
      ];
    })
  ];
}
