{...}:
# configure fd.
{
  programs.fd = {
    enable = true;

    # enable hidden files and colored output.
    hidden = true;
    extraOptions = [
      "--color"
      "always"
    ];
  };
}
