{
  osConfig,
  lib,
  pkgs,
  ...
}:
# Configure Prism Launcher.
let
  inherit (lib) attrValues;
in {
  programs.prismlauncher = {
    enable = true;

    package = pkgs.prismlauncher.override {
      # Disable unneeded support.
      controllerSupport = false;
      gamemodeSupport = false;
      textToSpeechSupport = false;

      # Specify which Java runtimes to install.
      jdks = attrValues {
        inherit (pkgs.graalvmPackages) graalvm-ce;
        inherit
          (pkgs)
          jdk21
          jdk17
          jdk8
          ;
      };
    };

    settings = {
      LastHostname = osConfig.networking.hostName;

      ApplicationTheme = "system";
      IconTheme = "pe_colored";

      StatusBarVisible = true;
      ToolbarsLocked = false;
    };
  };
}
