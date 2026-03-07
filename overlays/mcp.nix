{inputs, ...}: final: prev:
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

  # Pin mcp-nixos to the nixpkgs main update until it reaches unstable.
  mcp-nixos = prev.mcp-nixos.overrideAttrs (_old: rec {
    version = "2.3.0";

    src = final.fetchFromGitHub {
      owner = "utensils";
      repo = "mcp-nixos";
      tag = "v${version}";
      hash = "sha256-ogAug05ChGLSJ+KvmP5xXreDhkLHau15Wnp0ry7Ck88=";
    };
  });
}
