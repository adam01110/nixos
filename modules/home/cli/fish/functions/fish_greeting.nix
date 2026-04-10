{
  # keep-sorted start
  lib,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit (builtins) attrValues;
  inherit
    (lib)
    # keep-sorted start
    getExe
    makeBinPath
    # keep-sorted end
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
                # keep-sorted start
                boxes
                fortune
                # keep-sorted end
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
