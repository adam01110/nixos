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

    # it breaks when i set it?
    # set ui preferences.
    #settings = {
    #  inherit username;
    #  uitheme = "theme-night";
    #  uiscaling = 100;
    #  usegpu = true;
    #  titlebar = "system";
    #};
  };
}
