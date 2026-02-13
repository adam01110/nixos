{
  lib,
  pkgs,
  ...
}:
# Fish greeting function.
let
  inherit (builtins) attrValues;
  inherit
    (lib)
    getExe
    makeBinPath
    ;
  inherit (pkgs.writers) writeFishBin;
in {
  programs.fish.functions.fish_greeting = {
    description = "Greeting to show when starting a fish shell.";
    body = ''
      ${getExe (writeFishBin "fish-greeting"
        {
          makeWrapperArgs = [
            "--prefix"
            "PATH"
            ":"
            (makeBinPath (attrValues {
              inherit
                (pkgs)
                fortune
                boxes
                ;
            }))
          ];
        }
        ''
          fortune -s | boxes -d ansi
        '')}
    '';
  };
}
