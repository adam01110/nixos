{
  pkgs,
  inputs,
  system,
  ...
}:

# configure codex cli and the acp.
{
  programs.codex = {
    enable = true;
    package = inputs.nix-ai-tools.packages.${system}.codex;

    # set settings for codex cli.
    settings = {
      model = "gpt-5.1-codex-max";
      model_reasoning_effort = "medium";

      features = {
        web_search_request = true;
        rmcp_client = true;
      };

      # disable annoying notices.
      notice."hide_gpt-5.1-codex-max_migration_prompt" = true;
      check_for_update_on_startup = false;

      # use the keyring for storing login creds.
      cli_auth_credentials_store = "keyring";

      # enable reasoning summary.
      model_reasoning_summary_format = "experimental";
      hide_agent_reasoning = false;

      # disable some sandboxing.
      sandbox_mode = "workspace-write";
      approval_policy = "on-failure";

      # add mcp servers
      mcp_servers = {
        # nix tooling mcp.
        nix = {
          command = "mcp-nixos";
          args = [ "--" ];
        };
      };
    };
  };

  home.packages = [ pkgs.mcp-nixos ];
}
