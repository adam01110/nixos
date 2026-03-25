_: {
  programs.television = let
    enableShellIntegration = false;
  in {
    enable = true;

    enableBashIntegration = enableShellIntegration;
    enableFishIntegration = enableShellIntegration;
    enableZshIntegration = enableShellIntegration;
  };
}
