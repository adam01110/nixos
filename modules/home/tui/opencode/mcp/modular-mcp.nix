{
  config,
  lib,
  pkgs,
  ...
}:
# Provide mcp server config and token wrappers.
let
  inherit
    (lib)
    getExe
    getExe'
    ;
  inherit (pkgs) writeShellApplication;

  jsonFormat = pkgs.formats.json {};

  inherit
    (pkgs)
    context7-mcp
    github-mcp-server
    ;
in {
  sops = {
    secrets = {
      "ai/github_access_token" = {};
      "ai/context7_key" = {};
    };
  };

  xdg.configFile."modular-mcp.json".source = jsonFormat.generate "modular-mcp.json" {
    "$schema" = "https://raw.githubusercontent.com/d-kimuson/modular-mcp/refs/heads/main/config-schema.json";
    mcpServers = let
      cat = getExe' pkgs.coreutils "cat";
    in {
      context7 = {
        description = ''
          **Always use Context7 when I need code generation, setup or configuration steps, or library/API documentation.**
          Automatically call the Context7 MCP tools to resolve library IDs and retrieve documentation without me having to explicitly ask.
        '';

        command = getExe (writeShellApplication {
          name = "context7-mcp-wrapper";
          text = ''
            CONTEXT7_API_KEY="$(${cat} "${config.sops.secrets."ai/context7_key".path}")"
            export CONTEXT7_API_KEY
            exec "${getExe context7-mcp}" "$@"
          '';
        });
      };

      github = {
        description = ''
          **Always use the GitHub MCP server for anything related to GitHub**
          (repositories, code, issues, pull requests, commits, branches, releases, workflows, Actions, CI/CD, collaborators, permissions, repository metadata).
          Automatically call the GitHub MCP tools for GitHub operations without me having to explicitly ask.
        '';

        command = getExe (writeShellApplication {
          name = "github-mcp-server-wrapper";
          text = ''
            GITHUB_PERSONAL_ACCESS_TOKEN="$(${cat} "${config.sops.secrets."ai/github_access_token".path}")"
            export GITHUB_PERSONAL_ACCESS_TOKEN
            exec "${getExe github-mcp-server}" "$@"
          '';
        });
        args = ["stdio" "--read-only"];
      };
    };
  };
}
