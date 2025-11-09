{
  inputs,
  system,
  ...
}:

{
  programs.codex = {
    enable = true;
    package = inputs.nix-ai-tools.packages.${system}.codex;

    settings = {
      model = "gpt-5-codex";
      model_reasoning_effort = "low";

      features = {
        web_search_request = true;
        rmcp_client = true;
      };
    };
  };

  home.packages = [ inputs.nix-ai-tools.packages.${system}.codex-acp ];
}
