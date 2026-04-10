{
  # keep-sorted start
  config,
  lib,
  osConfig,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit (lib) getExe;

  # Build repeated entries from URL patterns.
  mkEntries = run:
    map (url: {
      inherit url run;
    });

  piper = "faster-piper --";
  usePreloader = "faster-piper --rely-on-preloader";
in {
  programs.yazi = {
    # keep-sorted start block=yes newline_separated=yes
    # Register the faster-piper plugin source.
    plugins.faster-piper = pkgs.nur.repos.adam0.yaziPlugins.faster-piper;

    # Use faster-piper for markdown, archives, compressed text, sqlite, and systemd previews.
    settings.plugin = {
      # keep-sorted start newline_separated=yes
      # Preloaders that render content for faster-piper.
      prepend_preloaders =
        mkEntries "${piper} CLICOLOR_FORCE=1 glow -w=$w -s=dark -- \"$1\"" ["*.md"]
        ++
        # Archive files.
        mkEntries "${piper} tar tf \"$1\"" ["*.tar*"]
        ++
        # Compressed text files.
        mkEntries "${piper} gzip -dc \"$1\"" ["*.txt.gz"]
        ++
        # SQLite database files.
        mkEntries ''${piper} sqlite3 -readonly "$1" ".schema --indent"'' ["*.db" "*.sqlite" "*.sqlite3"]
        ++
        # Systemd service files.
        mkEntries ''${piper} ${getExe (import ../../../../../pkgs/scripts/systemd-status-preview.nix {
            inherit
              # keep-sorted start
              config
              osConfig
              pkgs
              # keep-sorted end
              ;
          })} --from-path "$1"'' ["*/systemd/*"];

      # Previewers routed through faster-piper.
      prepend_previewers =
        mkEntries usePreloader ["*.md"]
        ++
        # Archive files.
        mkEntries "${usePreloader} --format=url" ["*.tar*"]
        ++
        # Compressed text files.
        mkEntries usePreloader ["*.txt.gz"]
        ++
        # SQLite database files.
        mkEntries usePreloader ["*.db" "*.sqlite" "*.sqlite3"]
        ++
        # Systemd service files.
        mkEntries usePreloader ["*/systemd/*"];

      # keep-sorted end
    };
    # keep-sorted end
  };
}
