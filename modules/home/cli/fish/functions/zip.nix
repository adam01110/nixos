{
  lib,
  pkgs,
  ...
}:
# Fish archive creation helper for zip files.
let
  inherit (builtins) attrValues;
  inherit
    (lib)
    getExe
    makeBinPath
    ;
  inherit (pkgs.writers) writeFishBin;
in {
  programs.fish.functions.zip = {
    description = "Custom zip function.";
    body = ''
      ${getExe (writeFishBin "fish-zip"
        {
          makeWrapperArgs = [
            "--prefix"
            "PATH"
            ":"
            (makeBinPath (attrValues {
              inherit
                (pkgs)
                coreutils
                zip
                ;
            }))
          ];
        }
        ''
          if test (count $argv) -lt 2
              echo "Usage: zip <archive.zip> <file-or-dir> [...]"
              return 1
          end

          set -l archive_path $argv[1]
          set -l input_items $argv[2..-1]

          set -l valid_items
          for item in $input_items
              if not test -e $item
                  echo "'$item' does not exist"
                  continue
              end
              set -a valid_items $item
          end

          if test (count $valid_items) -eq 0
              return 1
          end

          zip -9 -r -v $archive_path -- $valid_items
        '')} $argv
    '';
  };
}
