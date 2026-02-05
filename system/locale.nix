_: let
  us = "en_US.UTF-8";
  nl = "nl_NL.UTF-8";
in {
  # Locale and i18n settings. adjust lc_* as desired per host.
  i18n = {
    defaultLocale = us;
    # Keep locale categories aligned to avoid mismatch warnings.
    extraLocaleSettings = {
      LC_CTYPE = us;
      LC_ADDRESS = nl;
      LC_MEASUREMENT = nl;
      LC_MESSAGES = us;
      LC_MONETARY = nl;
      LC_NAME = nl;
      LC_NUMERIC = nl;
      LC_PAPER = nl;
      LC_TELEPHONE = nl;
      LC_TIME = us;
      LC_COLLATE = us;
    };
  };
}
