{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe;

  inherit (config.xdg) configHome;
in {
  # Register modular-mcp server with opencode.
  programs.mcp = {
    enable = true;

    servers.modular-mcp = {
      command = getExe pkgs.nur.repos.adam0.modular-mcp;

      args = ["${configHome}/modular-mcp.json"];
    };
  };
}
