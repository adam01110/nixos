{
  lib,
  pkgs,
  ...
}:
# Fish archive extraction helper for zip files.
let
  inherit (builtins) attrValues;
  inherit
    (lib)
    getExe
    makeBinPath
    ;
  inherit (pkgs.writers) writeFishBin;
in {
  programs.fish.functions.unzip = {
    description = "Custom unzip function.";
    body = ''
      ${getExe (writeFishBin "fish-unzip"
        {
          makeWrapperArgs = [
            "--prefix"
            "PATH"
            ":"
            (makeBinPath (attrValues {
              inherit
                (pkgs)
                coreutils
                unzip
                ;
            }))
          ];
        }
        ''
          if test (count $argv) -eq 0
              echo "Usage: unzip <archive> [...]"
              return 1
          end

          for archive_path in $argv
              if not test -f $archive_path
                  echo "'$archive_path' is not a valid file"
                  continue
              end

              set entries (unzip -Z1 $archive_path)
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
                  set dest_dir (string replace -r '\\.zip$' "" -- (path basename -- $archive_path))
                  mkdir -p -- $dest_dir
              end

              unzip -qn $archive_path -d $dest_dir
          end
        '')} $argv
    '';
  };
}
