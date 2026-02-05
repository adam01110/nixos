{vars, ...}:
# Configure onlyoffice desktop.
let
  inherit (vars) username;
in {
  programs.onlyoffice = {
    enable = true;

    # Set ui preferences.
    settings = {
      inherit username;
      UITheme = "theme-dark";
      uiscaling = 100;
      usegpu = true;
    };
  };
}
