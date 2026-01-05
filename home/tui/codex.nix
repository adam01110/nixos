{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

# configure codex cli and the acp.
let
  inherit (lib) getExe';
  tomlFormat = pkgs.formats.toml { };
in
{
  programs.codex = {
    enable = true;

    package = pkgs.symlinkJoin {
      name = "codex";
      paths = [ pkgs.codex ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild =
        let
          config = inputs.mcp-servers-nix.lib.mkConfig pkgs {
            flavor = "codex";
            format = "toml-inline";
            fileName = ".mcp.toml";
            programs = {
              # set up mcp servers
              context7.enable = true;
              nixos.enable = true;
            };
          };
        in
        ''
          wrapProgram $out/bin/codex "--add-flags" "-c '$(cat ${config})'"
        '';
    };

    # set custom instructions so that it actually uses the mcp servers.
    custom-instructions = ''
      Always use context7 when I need code generation, setup or configuration steps, or
      library/API documentation. This means you should automatically use the Context7 MCP
      tools to resolve library id and get library docs without me having to explicitly ask.

      Always use the NixOS MCP resources for anything NixOS- or
      Home Manager–related (packages, options, flakes, channels, nix-darwin).
      This means you should automatically call the NixOS MCP tools to look up
      package/option info, versions, channels, or flakes without me having to ask explicitly.
    '';
  };

  # set settings for codex cli.
  home.file.".codex/config.toml".source = tomlFormat.generate "codex-config.toml" {
    model = "gpt-5.2-codex";
    model_reasoning_effort = "medium";

    features = {
      web_search_request = true;
      rmcp_client = true;
      unified_exec = true;
    };

    # disable annoying notices.
    check_for_update_on_startup = false;

    # use the keyring for storing login creds.
    cli_auth_credentials_store = "keyring";

    # enable reasoning summary.
    model_reasoning_summary_format = "experimental";
    hide_agent_reasoning = false;

    # disable some sandboxing.
    sandbox_mode = "workspace-write";
    approval_policy = "on-failure";
  };

  # create desktop entry to allow launching via launcher.
  xdg.desktopEntries.codex = {
    name = "Codex";
    genericName = "AI Coding Assistant";
    exec = getExe' config.programs.codex.package "codex";
    terminal = true;
    categories = [
      "Development"
      "Utility"
    ];
  };
}
