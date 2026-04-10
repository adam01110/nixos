_:
# Configure fd.
{
  programs.fd = {
    enable = true;

    # Enable hidden files and colored output.
    hidden = true;
    extraOptions = [
      # keep-sorted start
      "--color"
      "always"
      # keep-sorted end
    ];
  };
}
