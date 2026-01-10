{
  lib,
  pkgs,
  inputs,
  system,
  ...
}: let
  inherit
    (lib)
    getExe
    getExe'
    ;
in {
  programs.mcp = {
    enable = true;

    servers = {
      nix.command = getExe' inputs.mcp-nix.packages.${system}.default "mcp-nix";
      context7.command = getExe' inputs.mcp-servers-nix.packages.${system}.context7-mcp "context7-mcp";
      github.command = getExe pkgs.github-mcp-server;
    };
  };
}
