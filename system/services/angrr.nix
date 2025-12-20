{ ... }:

# keep nix gc roots retained automatically via angrr.
{
  services.angrr = {
    # run angrr daemon to track and protect gc roots.
    enable = true;

    # schedule periodic refresh of retained roots.
    timer.enable = true;

    settings = {
      temporary-root-policies = {
        direnv = {
          path-regex = "/\\.direnv/";
          period = "14d";
        };
        result = {
          path-regex = "/result[^/]*$";
          period = "2d";
        };
      };
      profile-policies = {
        system = {
          profile-paths = [ "/nix/var/nix/profiles/system" ];
          keep-since = "4d";
          keep-latest-n = 4;
          keep-booted-system = true;
          keep-current-system = true;
        };
        user = {
          enable = true;
          profile-paths = [
            "~/.local/state/nix/profiles/profile"
            "/nix/var/nix/profiles/per-user/root/profile"
          ];
          keep-since = "1d";
          keep-latest-n = 1;
        };
      };
    };
  };
}
