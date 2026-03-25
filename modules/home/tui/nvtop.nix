{
  config,
  lib,
  pkgs,
  ...
}:
# Configure nvtop.
let
  inherit
    (lib)
    mkOption
    types
    optional
    ;
in {
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
    default = [];
    description = "Choose which GPU types to monitor with nvtop.";
  };

  # Override enables multiple gpu backends in single nvtop instance.
  config.home.packages = let
    selectedTypes = config.nvtop.types;
    base = lib.head selectedTypes;
    extras = lib.tail selectedTypes;
    backends = lib.foldl' (acc: t: acc // {${t} = true;}) {} selectedTypes;
    package =
      if extras == []
      then pkgs.nvtopPackages.${base}
      else pkgs.nvtopPackages.${base}.override backends;
  in
    # Only install nvtop when gpu types are specified.
    optional (selectedTypes != []) package;
}
