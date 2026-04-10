_:
# Configure zathura pdf viewer options.
{
  programs.zathura = {
    enable = true;

    options = {
      # Enable recoloring of documents.
      # keep-sorted start
      recolor = true;
      recolor-keephue = true;
      # keep-sorted ends

      # keep-sorted start block=yes newline_separated=yes
      # Use the system clipboard for text selection.
      selection-clipboard = "clipboard";

      # Show hidden files for complete filesystem access.
      show-hidden = true;
      # keep-sorted end
    };
  };
}
