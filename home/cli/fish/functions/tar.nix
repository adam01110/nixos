{
  lib,
  pkgs,
  ...
}:
# Fish archive creation helper for tar files.
let
  inherit (builtins) attrValues;
  inherit
    (lib)
    getExe
    makeBinPath
    ;
  inherit (pkgs.writers) writeFishBin;
in {
  programs.fish.functions.tar = {
    description = "Custom tar function.";
    body = ''
      ${getExe (writeFishBin "fish-tar"
        {
          makeWrapperArgs = [
            "--prefix"
            "PATH"
            ":"
            (makeBinPath (attrValues {
              inherit
                (pkgs)
                coreutils
                gnutar
                ;
            }))
          ];
        }
        ''
          if test (count $argv) -lt 2
              echo "Usage: tar <archive.tar.*> <file-or-dir> [...]"
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

          set -l flags
          switch $archive_path
              case '*.tar.gz'
                  set flags -cvzf
              case '*.tar.bz2'
                  set flags -cvjf
              case '*.tar.xz'
                  set flags -cvJf
              case '*.tar.zst'
                  set flags --zstd -cvf
              case '*.tar'
                  set flags -cvf
              case '*'
                  echo "Unsupported archive extension for '$archive_path'"
                  echo "Use one of: .tar, .tar.gz, .tar.bz2, .tar.xz, .tar.zst"
                  return 1
          end

          tar $flags $archive_path $valid_items
        '')} $argv
    '';
  };
}
