{ ... }:

# configure zathura pdf viewer options.
{
  programs.zathura = {
    enable = true;

    options = {
      # enable recoloring of documents.
      recolor = true;
      recolor-keephue = true;

      # show hidden files?
      show-hidden = true;

      # use the system clipboard
      selection-clipboard = "clipboard";
    };
  };
}
