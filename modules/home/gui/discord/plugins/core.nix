_:
# Core equibop plugins and global toggles.
{
  programs.nixcord.config.plugins = {
    # keep-sorted start block=yes
    AlwaysTrust.enable = true;
    BetterSessions = {
      enable = true;
      backgroundCheck = true;
      checkInterval = 30;
      ConsoleJanitor = {
        enable = true;

        # keep-sorted start
        disableLoggers = true;
        disableSpotifyLogger = true;
        # keep-sorted end

        allowLevel = {
          # keep-sorted start
          debug = false;
          error = false;
          info = false;
          log = false;
          trace = false;
          warn = false;
          # keep-sorted end
        };
        CrashHandler.attemptToNavigateToHome = true;
        Declutter.enable = true;
        EquibopStreamFixes.enable = true;
        NewPluginsManager.enable = true;
        NoDevtoolsWarning.enable = true;
        NoF1.enable = true;
        NoOnboardingDelay.enable = true;
        PermissionFreeWill.enable = true;
        StartupTimings.enable = true;
        UnlimitedAccounts.enable = true;
        ValidUser.enable = true;
      };
      # keep-sorted end
    };
  };
}
