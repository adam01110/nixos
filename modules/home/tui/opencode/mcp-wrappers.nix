{
  config,
  lib,
  pkgs,
  ...
}:
# Build shared mcp wrappers with secret-backed credentials.
let
  inherit
    (lib)
    getExe
    getExe'
    ;
  inherit (pkgs) writeShellApplication;

  cat = getExe' pkgs.coreutils "cat";

  context7McpWrapper = writeShellApplication {
    name = "context7-mcp-wrapper";
    text = ''
      CONTEXT7_API_KEY="$(${cat} "${config.sops.secrets."ai/context7_key".path}")"
      export CONTEXT7_API_KEY
      exec "${getExe pkgs.context7-mcp}" "$@"
    '';
  };

  githubMcpServerWrapper = writeShellApplication {
    name = "github-mcp-server-wrapper";
    text = ''
      GITHUB_PERSONAL_ACCESS_TOKEN="$(${cat} "${config.sops.secrets."ai/github_access_token".path}")"
      export GITHUB_PERSONAL_ACCESS_TOKEN
      exec "${getExe pkgs.github-mcp-server}" stdio --read-only "$@"
    '';
  };
in {
  sops.secrets = {
    "ai/github_access_token" = {};
    "ai/context7_key" = {};
  };

  _module.args.mcpWrappers = {
    inherit
      context7McpWrapper
      githubMcpServerWrapper
      ;
  };
}
