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
      model = "gpt-5-codex";
      model_reasoning_effort = "medium";

      features = {
        web_search_request = true;
        rmcp_client = true;
      };
    };
  };

  # install the codex acp.
  home.packages = [ inputs.nix-ai-tools.packages.${system}.codex-acp ];
}
