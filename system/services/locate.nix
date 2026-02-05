_: {
  # Daily updatedb for file search with locate.
  services.locate = {
    enable = true;
    # Run updatedb daily to balance freshness and io time.
    interval = "daily";
  };
}
