{vars, ...}:
# Locale defaults and category-specific regional overrides.
let
  inherit
    (vars)
    # keep-sorted start
    defaultLocale
    regionalLocale
    # keep-sorted end
    ;
in {
  # Split message and collation locales from regional formatting defaults.
  i18n = {
    inherit defaultLocale;
    # Keep locale categories explicit so mixed language and regional settings stay consistent.
    extraLocaleSettings = {
      # keep-sorted start
      LC_ADDRESS = regionalLocale;
      LC_COLLATE = defaultLocale;
      LC_CTYPE = defaultLocale;
      LC_MEASUREMENT = regionalLocale;
      LC_MESSAGES = defaultLocale;
      LC_MONETARY = regionalLocale;
      LC_NAME = regionalLocale;
      LC_NUMERIC = regionalLocale;
      LC_PAPER = regionalLocale;
      LC_TELEPHONE = regionalLocale;
      LC_TIME = defaultLocale;
      # keep-sorted end
    };
  };
}
