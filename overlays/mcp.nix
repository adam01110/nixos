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

  mcpPackages = inputs.mcp-servers-nix.packages.${system};
in {
  inherit
    (mcpPackages)
    context7-mcp
    mcp-server-git
    ;

  mcp-nixos = fromInput {
    input = "mcp-nixos";
    package = "mcp-nixos";
  };
}
