{inputs, ...}:
# Treefmt-nix configuration for flake-parts.
{
  # import the treefmt flake-parts module.
  imports = [inputs.treefmt-nix.flakeModule];

  perSystem = _: {
    treefmt = {
      projectRootFile = "flake.nix";

      # Keep sops and direnv files out of formatting and linting.
      settings.global.excludes = [
        ".direnv/*"
        ".sops.yaml"
        "secrets/secrets.yaml"
      ];

      programs = {
        alejandra.enable = true;
        nixf-diagnose.enable = true;
        deadnix.enable = true;
        statix.enable = true;

        biome.enable = true;

        shfmt.enable = true;
        shellcheck = {
          enable = true;
          severity = "style";
        };

        yamlfmt.enable = true;
        yamllint.enable = true;

        stylua.enable = true;

        rumdl-format.enable = true;
      };
    };
  };
}
