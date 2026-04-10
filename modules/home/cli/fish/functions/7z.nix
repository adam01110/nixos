{
  # keep-sorted start
  lib,
  pkgs,
  # keep-sorted end
  ...
}:
# Fish archive creation helper for 7z files.
let
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
  programs.fish.functions."7z" = {
    description = "Custom 7z function.";
    body = ''
      ${getExe (writeFishBin "fish-7z"
        {
          makeWrapperArgs = [
            "--prefix"
            "PATH"
            ":"
            (makeBinPath (attrValues {
              inherit
                (pkgs)
                # keep-sorted start
                _7zz
                coreutils
                # keep-sorted end
                ;
            }))
          ];
        }
        ''
          if test (count $argv) -lt 2
              echo "Usage: 7z <archive.7z> <file-or-dir> [...]"
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

          7zz a -t7z -mx=9 -mmt=on -bb3 -- $archive_path $valid_items
        '')} $argv
    '';
  };
}
