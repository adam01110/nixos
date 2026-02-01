_: {
  programs = let
    sopsExcludes = [
      ".sops.yaml"
      "secrets/secrets.yaml"
    ];
  in {
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

    qmlformat.enable = true;

    yamlfmt = {
      enable = true;
      excludes = sopsExcludes;
    };
    yamllint = {
      enable = true;
      excludes = sopsExcludes;
    };

    fish_indent.enable = true;

    taplo.enable = true;

    stylua.enable = true;

    rumdl-check.enable = true;
    rumdl-format.enable = true;
  };
}
