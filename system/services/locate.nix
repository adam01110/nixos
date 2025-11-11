{ ... }:

{
  # daily updatedb for file search with locate.
  services.locate = {
    enable = true;
    interval = "daily";
  };
}
