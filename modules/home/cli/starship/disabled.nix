{lib, ...}:
# Disable unwanted modules to keep the prompt minimal.
let
  inherit (lib) genAttrs;
  disabled = targets: genAttrs targets (_: {disabled = true;});
in {
  programs.starship.settings = disabled [
    # keep-sorted start
    "aws"
    "battery"
    "buf"
    "cobol"
    "conda"
    "crystal"
    "daml"
    "elixir"
    "elm"
    "env_var"
    "erlang"
    "fennel"
    "fill"
    "fossil_metrics"
    "gcloud"
    "gleam"
    "guix_shell"
    "helm"
    "julia"
    "kubernetes"
    "mojo"
    "nats"
    "netns"
    "nim"
    "ocaml"
    "odin"
    "opa"
    "openstack"
    "pixi"
    "pulumi"
    "purescript"
    "quarto"
    "raku"
    "red"
    "rlang"
    "scala"
    "singularity"
    "solidity"
    "spack"
    "terraform"
    "typst"
    "vagrant"
    "vcsh"
    "vlang"
    # keep-sorted end
  ];
}
