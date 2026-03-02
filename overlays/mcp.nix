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

  # Use upstream fix branch until it lands in the packaged release.
  mcp-nixos = prev.mcp-nixos.overrideAttrs (_old: {
    src = final.fetchFromGitHub {
      owner = "DavidDudson";
      repo = "mcp-nixos";
      rev = "0b863c25e2f782fdca0a921c772d576ad04b60a2";
      hash = "sha256-rWdNdkN9ABEdPTfu/cNNeOQq/Vc6krp4VL+QemCaytQ=";
    };
  });
}
