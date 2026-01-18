{pkgs, ...}:
# configure thunar with core plugins for archives and removable media.
{
  programs = {
    xfconf.enable = true;

    thunar = {
      enable = true;

      plugins = let
        pluginNames = [
          "archive"
          "volman"
          "media-tags"
        ];
      in
        map (
          name: let
            suffix =
              if name == "volman"
              then ""
              else "-plugin";
          in
            pkgs."thunar-${name}${suffix}"
        )
        pluginNames;
    };
  };

  environment.systemPackages = [
    (pkgs.file-roller.overrideAttrs (old: let
      removeNautilus = pkgList:
        pkgs.lib.filter (pkg: pkg != pkgs.nautilus) pkgList;
    in {
      buildInputs = removeNautilus (old.buildInputs or []);
      propagatedBuildInputs = removeNautilus (old.propagatedBuildInputs or []);
      mesonFlags = (old.mesonFlags or []) ++ ["-Dnautilus-actions=disabled"];
    }))
  ];
}
