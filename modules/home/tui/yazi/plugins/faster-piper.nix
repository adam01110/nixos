{pkgs, ...}: let
  # Build repeated entries from URL patterns.
  mkEntries = run:
    map (url: {
      inherit url run;
    });

  piper = "faster-piper --";
  usePreloader = "faster-piper --rely-on-preloader";
in {
  # Register the faster-piper plugin source.
  programs.yazi.plugins.faster-piper = pkgs.nur.repos.adam0.yaziPlugins.faster-piper;

  # Use faster-piper for markdown, archives, compressed text, and sqlite previews.
  programs.yazi.settings.plugin = {
    # Previewers routed through faster-piper.
    prepend_previewers =
      # Markdown files.
      mkEntries usePreloader ["*.md"]
      ++
      # Archive files.
      mkEntries "${usePreloader} --format=url" ["*.tar*"]
      ++
      # Compressed text files.
      mkEntries usePreloader ["*.txt.gz"]
      ++
      # SQLite database files.
      mkEntries usePreloader ["*.db" "*.sqlite" "*.sqlite3"];

    # Preloaders that render content for faster-piper.
    prepend_preloaders =
      # Markdown files.
      mkEntries "${piper} CLICOLOR_FORCE=1 glow -w=$w -s=dark -- \"$1\"" ["*.md"]
      ++
      # Archive files.
      mkEntries "${piper} tar tf \"$1\"" ["*.tar*"]
      ++
      # Compressed text files.
      mkEntries "${piper} gzip -dc \"$1\"" ["*.txt.gz"]
      ++
      # SQLite database files.
      mkEntries ''${piper} sqlite3 -readonly "$1" ".schema --indent"'' ["*.db" "*.sqlite" "*.sqlite3"];
  };
}
