_: {
  programs.fzf = let
    enableShellIntegration = false;
  in {
    enable = true;

    # keep-sorted start
    enableBashIntegration = enableShellIntegration;
    enableFishIntegration = enableShellIntegration;
    enableZshIntegration = enableShellIntegration;
    # keep-sorted end

    # Change prompt default to look better.
    defaultOptions = [
      # keep-sorted start
      "--border sharp"
      "--prompt '➜ '"
      # keep-sorted end
    ];
  };
}
