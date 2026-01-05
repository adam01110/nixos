{
  vars,
  ...
}:

# configure onlyoffice desktop.
let
  inherit (vars) username;
in
{
  programs.onlyoffice = {
    enable = true;

    # set ui preferences.
    settings = {
      inherit username;
      UITheme = "theme-dark";
      uiscaling = 100;
      usegpu = true;
    };
  };
}
