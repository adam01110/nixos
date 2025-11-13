{ ... }:

{
  programs.spicetify = {
    enable = true;

    experimentalFeatures = true;
    windowManagerPatch = true;
  };

  enabledExtensions = [ ];
}
