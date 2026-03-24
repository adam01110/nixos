{
  inputs,
  lib,
  ...
}: final: prev:
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
    # Disable the per-test meson timeout to avoid flaky gtksourceview5 builds.
    gtksourceview5 = prev.gtksourceview5.overrideAttrs (old: {
      checkPhase =
        if lib.hasInfix "--timeout-multiplier 0" old.checkPhase
        then old.checkPhase
        else
          builtins.replaceStrings
          ["meson test --no-rebuild --print-errorlogs"]
          ["meson test --no-rebuild --print-errorlogs --timeout-multiplier 0"]
          old.checkPhase;
    });
  }
