{vars, ...}:
# Configure onlyoffice desktop.
let
  inherit (vars) fullName;
in {
  programs.onlyoffice = {
    enable = true;

    # Set ui preferences.
    settings = {
      username = fullName;
      UITheme = "theme-dark";
      uiscaling = 100;
      usegpu = true;
    };
  };
}
