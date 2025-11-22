{
  config,
  lib,
  pkgs,
  ...
}:

# configure nvtop.
let
  inherit (lib)
    mkOption
    types
    optional
    foldl'
    head
    tail
    ;
in
{
  options.nvtop.types = mkOption {
    type = types.listOf (
      types.enum [
        "amd"
        "intel"
        "nvidia"
        "v3d"
        "msm"
        "panthor"
        "panfrost"
        "apple"
      ]
    );
    default = [ ];
    description = "Choose which GPU types to monitor with nvtop.";
  };

  # pick a flavor then enable additional backends via override.
  config.home.packages =
    let
      selectedTypes = config.nvtop.types;
      base = head selectedTypes;
      extras = tail selectedTypes;
      backends = foldl' (acc: t: acc // { ${t} = true; }) { } selectedTypes;
      package =
        if extras == [ ] then pkgs.nvtopPackages.${base} else pkgs.nvtopPackages.${base}.override backends;
    in
    optional (selectedTypes != [ ]) package;
}
