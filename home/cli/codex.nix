{
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

      notice."hide_gpt-5.1-codex-max_migration_prompt" = true;
    };
  };
}
