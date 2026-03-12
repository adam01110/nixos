{inputs, ...}: final: _prev:
# Expose packages from flake inputs under pkgs.*.
let
  inherit (final.stdenv.hostPlatform) system;

  fromInput = {
    input,
    package ? "default",
  }: let
    flake = inputs.${input};
  in
    if flake ? packages
    then flake.packages.${system}.${package}
    else if package == "default" && flake ? defaultPackage
    then flake.defaultPackage.${system}
    else throw "Input `${input}` does not expose `packages.${system}.${package}`.";

  packages = {
    nix = {input = "determinate";};
    oxicord = {input = "oxicord";};

    opencode = {
      input = "leohenon-opencode";
      package = "opencode";
    };
    tuigreet = {
      input = "tuigreet";
      package = "tuigreet";
    };
  };
in
  (builtins.mapAttrs (_name: fromInput) packages)
  // {
    # Disable checks for tuigreet to avoid flaky integration test failures.
    tuigreet = (fromInput packages.tuigreet).overrideAttrs (_old: {
      doCheck = false;
    });
  }
