_:
# Configure zathura pdf viewer options.
{
  programs.zathura = {
    enable = true;

    options = {
      # Enable recoloring of documents.
      recolor = true;
      recolor-keephue = true;

      # Show hidden files for complete filesystem access.
      show-hidden = true;

      # Use the system clipboard for text selection.
      selection-clipboard = "clipboard";
    };
  };
}
