{inputs, ...}:
# Treefmt-nix configuration for flake-parts.
{
  # import the treefmt flake-parts module.
  imports = [inputs.treefmt-nix.flakeModule];

  perSystem = _: {
    treefmt = {
      # keep-sorted start block=yes newline_separated=yes
      programs = {
        # keep-sorted start
        alejandra.enable = true;
        deadnix.enable = true;
        nixf-diagnose.enable = true;
        statix.enable = true;
        # keep-sorted end

        biome.enable = true;

        # keep-sorted start block=yes
        shellcheck = {
          enable = true;
          severity = "style";
        };
        shfmt.enable = true;
        # keep-sorted end

        # keep-sorted start
        yamlfmt.enable = true;
        yamllint.enable = true;
        # keep-sorted end

        stylua.enable = true;

        rumdl-format.enable = true;

        keep-sorted.enable = true;
      };

      projectRootFile = "flake.nix";

      # Keep sops and direnv files out of formatting and linting.
      settings.global.excludes = [
        # keep-sorted start
        ".direnv/*"
        ".sops.yaml"
        "secrets/secrets.yaml"
        # keep-sorted end
      ];
      # keep-sorted end
    };
  };
}
