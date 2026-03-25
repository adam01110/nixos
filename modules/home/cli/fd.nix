_:
# Configure fd.
{
  programs.fd = {
    enable = true;

    # Enable hidden files and colored output.
    hidden = true;
    extraOptions = [
      "--color"
      "always"
    ];
  };
}
