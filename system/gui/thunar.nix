{ pkgs, ... }:

# configure thunar with core plugins for archives and removable media.

{
  programs = {
    xfconf.enable = true;

    thunar = {
      enable = true;

      plugins =
        let
          pluginNames = [
            "archive"
            "volman"
            "vcs"
            "media-tags"
          ];
        in
        pluginNames
        |> map (
          name:
          let
            suffix = if name == "volman" then "" else "-plugin";
          in
          pkgs.xfce."thunar-${name}${suffix}"
        );
    };
  };

  environment.systemPackages = [ pkgs.file-roller ];
}
