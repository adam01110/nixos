{...}: {
  programs.zen-browser.policies = {
    AutofillAddressEnabled = false;
    AutofillCreditCardEnabled = false;
    DisableAppUpdate = true;
    DisableFeedbackCommands = true;
    DisableFirefoxScreenshots = true;
    DisableFirefoxStudies = true;
    DisableForgetButton = true;
    DisableFormHistory = true;
    DisableMasterPasswordCreation = true;
    DisablePasswordReveal = true;
    DisablePocket = true;
    DisableSafeMode = true;
    DisableSetDesktopBackground = true;
    DisableTelemetry = true;
    DontCheckDefaultBrowser = true;
    NoDefaultBookmarks = true;
    OfferToSaveLogins = false;
    PasswordManagerEnabled = false;
    SkipTermsOfUse = true;
    TranslateEnabled = false;
    SearchSuggestEnabled = false;
    HttpsOnlyMode = true;
    PDFjs.Enabled = false;
    StartDownloadsInTempDirectory = true;

    GenerativeAI = {
      Enabled = false;
      Chatbot = false;
      LinkPreviews = false;
      TabGroups = false;
      Locked = true;
    };

    EnableTrackingProtection = {
      Value = true;
      Locked = true;
      Cryptomining = true;
      Fingerprinting = true;
    };
  };
}
