{vars, ...}: let
  inherit
    (vars)
    defaultLocale
    regionalLocale
    ;
in {
  # Locale and i18n settings. adjust lc_* as desired per host.
  i18n = {
    inherit defaultLocale;
    # Keep locale categories aligned to avoid mismatch warnings.
    extraLocaleSettings = {
      LC_CTYPE = defaultLocale;
      LC_ADDRESS = regionalLocale;
      LC_MEASUREMENT = regionalLocale;
      LC_MESSAGES = defaultLocale;
      LC_MONETARY = regionalLocale;
      LC_NAME = regionalLocale;
      LC_NUMERIC = regionalLocale;
      LC_PAPER = regionalLocale;
      LC_TELEPHONE = regionalLocale;
      LC_TIME = defaultLocale;
      LC_COLLATE = defaultLocale;
    };
  };
}
