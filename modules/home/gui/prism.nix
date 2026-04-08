{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
# Configure Prism Launcher.
let
  inherit
    (lib)
    attrValues
    getExe
    removeSuffix
    ;

  # Reuse the XDG downloads path for launcher-managed downloads.
  downloadsDir = config.xdg.userDirs.download;
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
        inherit
          (pkgs)
          temurin-bin-25
          jdk21
          jdk17
          jdk8
          ;
      };
    };

    settings = {
      # Derive identity and language from host-level configuration.
      LastHostname = osConfig.networking.hostName;
      Language = removeSuffix ".UTF-8" osConfig.i18n.defaultLocale;
      UseSystemLocale = true;

      # Follow desktop theming and use the flat white icon pack.
      ApplicationTheme = "system";
      IconTheme = "flat_white";

      # Keep status and toolbar controls visible in the main window.
      StatusBarVisible = true;
      ToolbarsLocked = false;

      # Set the console font.
      ConsoleFontSize = 11;
      ConsoleMaxLines = 100000;
      ConsoleOverflowStop = true;

      # Keep console hidden during normal launches and failures.
      ShowConsole = false;
      ShowConsoleOnError = false;

      # Pin Java behavior to managed Nix-provided runtimes.
      JavaPath = getExe pkgs.temurin-bin-25;
      IgnoreJavaCompatibility = true;
      IgnoreJavaWizard = true;
      AutomaticJavaDownload = false;
      AutomaticJavaSwitch = false;
      UserAskedAboutAutomaticJavaDownload = false;

      # Set default JVM memory values for instances.
      MaxMemAlloc = 8192;
      MinMemAlloc = 1024;
      PermGen = 128;

      # Track downloads in the shared user downloads directory.
      DownloadsDir = downloadsDir;
      DownloadsDirWatchRecursive = false;

      # Disable optional runtime overlays and gamemode integration.
      EnableFeralGamemode = false;
      EnableMangoHud = false;

      # Keep dependency checks and manual mod movement enabled.
      ModDependenciesDisabled = false;
      MoveModsFromDownloadsDir = false;

      # Increase worker counts and retry limits for large packs.
      NumberOfConcurrentDownloads = 10;
      NumberOfConcurrentTasks = 10;
      NumberOfManualRetries = 10;

      # Avoid experimental online patch behavior.
      OnlineFixes = false;

      # Close launcher and console after a successful game start.
      AutoCloseConsole = true;
      CloseAfterLaunch = true;

      # Keep per-instance and aggregate playtime tracking visible.
      RecordGameTime = true;
      ShowGameTime = true;
      ShowGameTimeWithoutDays = true;
      ShowGlobalGameTime = true;

      # Disable optional novelty feature flags.
      TheCat = false;

      # Keep rendering defaults without forcing discrete GPU paths.
      UseDiscreteGpu = false;
      UseNativeGLFW = true;
      UseNativeOpenAL = true;
      UseZink = false;
    };
  };
}
