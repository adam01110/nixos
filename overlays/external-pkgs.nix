{inputs, ...}: final: _prev:
# expose packages from flake inputs under pkgs.*.
let
  inherit (final.stdenv.hostPlatform) system;

  fromInput = {
    input,
    package ? "default",
  }:
    inputs.${input}.packages.${system}.${package};

  packages = {
    determinate-nix = {input = "determinate";};
    neovim-nightly = {input = "neovim-nightly-overlay";};
    oxicord = {input = "oxicord";};

    opencode = {
      input = "llm-agents";
      package = "opencode";
    };
    tuigreet = {
      input = "tuigreet";
      package = "tuigreet";
    };
  };
in
  builtins.mapAttrs (_name: spec: fromInput spec) packages
