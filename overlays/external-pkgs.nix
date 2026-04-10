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
    # keep-sorted start block=yes newline_separated=yes
    nix.input = "determinate";

    oxicord.input = "oxicord";

    tuigreet = {
      input = "tuigreet";
      package = "tuigreet";
    };
    # keep-sorted end
  };
in
  builtins.mapAttrs (_name: fromInput) packages
