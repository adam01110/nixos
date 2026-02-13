{
  lib,
  pkgs,
  ...
}:
# Fish archive extraction helper for 7z files.
let
  inherit (builtins) attrValues;
  inherit
    (lib)
    getExe
    makeBinPath
    ;
  inherit (pkgs.writers) writeFishBin;
in {
  programs.fish.functions.un7z = {
    description = "Custom un7z function.";
    body = ''
      ${getExe (writeFishBin "fish-un7z"
        {
          makeWrapperArgs = [
            "--prefix"
            "PATH"
            ":"
            (makeBinPath (attrValues {
              inherit
                (pkgs)
                coreutils
                _7zz
                ;
            }))
          ];
        }
        ''
          if test (count $argv) -eq 0
              echo "Usage: un7z <archive> [...]"
              return 1
          end

          for archive_path in $argv
              if not test -f $archive_path
                  echo "'$archive_path' is not a valid file"
                  continue
              end

              set entries (7zz l -slt -ba $archive_path | string match -r '^Path = ' | string replace -r '^Path = ' "")
              if test (count $entries) -eq 0
                  echo "'$archive_path' has no entries to extract"
                  continue
              end

              set top_level_dir ""
              set has_dir 0
              set has_multiple 0

              for entry in $entries
                  if test -z "$entry"
                      continue
                  end

                  if string match -q '*/*' -- $entry
                      set has_dir 1
                  end

                  set entry_root (string split -m1 / -- $entry)[1]
                  if test -z "$entry_root"
                      continue
                  end

                  if test -z "$top_level_dir"
                      set top_level_dir $entry_root
                  else if test "$entry_root" != "$top_level_dir"
                      set has_multiple 1
                      break
                  end
              end

              if test $has_multiple -eq 0 -a $has_dir -eq 1 -a -n "$top_level_dir"
                  set dest_dir .
              else
                  set dest_dir (string replace -r '\\.7z$' "" -- (path basename -- $archive_path))
                  mkdir -p -- $dest_dir
              end

              set -l output_arg "-o$dest_dir"
              7zz x -y -bb3 $output_arg $archive_path
          end
        '')} $argv
    '';
  };
}
