{inputs, ...}: final: _prev:
# Expose packages from flake inputs under pkgs.*.
let
  inherit (final.stdenv.hostPlatform) system;
  mcpPackages = inputs.mcp-servers-nix.packages.${system};
in {
  inherit
    (mcpPackages)
    context7-mcp
    mcp-server-git
    ;
}
