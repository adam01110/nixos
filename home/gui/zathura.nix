{...}:
# configure zathura pdf viewer options.
{
  programs.zathura = {
    enable = true;

    options = {
      # enable recoloring of documents.
      recolor = true;
      recolor-keephue = true;

      # show hidden files for complete filesystem access.
      show-hidden = true;

      # use the system clipboard for text selection.
      selection-clipboard = "clipboard";
    };
  };
}
