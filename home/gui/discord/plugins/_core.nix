_:
# Core equibop plugins and global toggles.
{
  AlwaysTrust.enabled = true;
  Anammox.enabled = true;
  BetterSessions = {
    enabled = true;
    backgroundCheck = true;
    checkInterval = 30;
  };
  CrashHandler.attemptToNavigateToHome = true;
  NewPluginsManager.enabled = true;
  NoDevtoolsWarning.enabled = true;
  NoF1.enabled = true;
  NoOnboardingDelay.enabled = true;
  PermissionFreeWill.enabled = true;
  StartupTimings.enabled = true;
  UnlimitedAccounts.enabled = true;
  ValidUser.enabled = true;
  ConsoleJanitor = {
    enabled = true;

    disableLoggers = true;
    disableSpotifyLogger = true;

    allowLevel = {
      debug = false;
      error = false;
      info = false;
      log = false;
      trace = false;
      warn = false;
    };
  };
}
