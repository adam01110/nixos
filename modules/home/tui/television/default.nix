_:
# Enable television with shell integration disabled.
{
  programs.television = let
    # Disable shell hooks and use explicit invocation only.
    enableShellIntegration = false;
  in {
    enable = true;

    enableBashIntegration = enableShellIntegration;
    enableFishIntegration = enableShellIntegration;
    enableZshIntegration = enableShellIntegration;
  };
}
