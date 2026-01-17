_: {
  # daily updatedb for file search with locate.
  services.locate = {
    enable = true;
    # run updatedb daily to balance freshness and io time.
    interval = "daily";
  };
}
