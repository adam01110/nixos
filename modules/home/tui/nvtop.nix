{
  # keep-sorted start
  config,
  lib,
  pkgs,
  # keep-sorted end
  ...
}:
# Configure nvtop.
let
  inherit
    (lib)
    # keep-sorted start
    mkOption
    optional
    types
    # keep-sorted end
    ;
in {
  options.nvtop.types = mkOption {
    type = types.listOf (
      types.enum [
        # keep-sorted start
        "amd"
        "apple"
        "intel"
        "msm"
        "nvidia"
        "panfrost"
        "panthor"
        "v3d"
        # keep-sorted end
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
