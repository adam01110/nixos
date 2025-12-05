{ ... }:

# keep nix gc roots retained automatically via angrr.
{
  services.angrr = {
    # run angrr daemon to track and protect gc roots.
    enable = true;

    # schedule periodic refresh of retained roots.
    timer.enable = true;
  };
}
