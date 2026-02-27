{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (builtins) attrValues;
  inherit
    (lib)
    getExe
    getExe'
    makeBinPath
    ;

  inherit (pkgs) symlinkJoin;

  # Source a sops-rendered env snippet for the Morph API key at runtime.
  morphFastApplyEnv = config.sops.templates."opencode-morph-fast-apply-env".path;
in {
  sops = {
    # Declare the Morph API key secret.
    secrets."ai/morph_fast_apply_key" = {};

    # Render a shell snippet wrappers can source to export MORPH_API_KEY.
    templates."opencode-morph-fast-apply-env".content = ''
      export MORPH_API_KEY="${config.sops.placeholder."ai/morph_fast_apply_key"}"
    '';
  };

  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;

    # Wrap opencode with mcp's, formatters, and lsp's.
    package = symlinkJoin {
      name = "opencode-wrapped";
      paths = [pkgs.opencode];
      nativeBuildInputs = [pkgs.makeWrapper];

      # Source plugin credentials before launching the wrapped binary.
      postBuild = ''
        wrapProgram $out/bin/opencode \
          --run '. "${morphFastApplyEnv}"' \
          --prefix PATH : ${makeBinPath (attrValues {
          inherit (pkgs.nur.repos.adam0) modular-mcp;
          inherit
            (pkgs)
            wl-clipboard
            # Lsp's
            lua-language-server
            bash-language-server
            yaml-language-server
            vscode-json-languageserver
            ty
            oxlint
            taplo
            typescript-language-server
            rust-analyzer
            # Formatters
            alejandra
            biome
            fish
            stylua
            shfmt
            ruff
            rustfmt
            ;
        })}
      '';
    };

    # Set agent rules.
    rules = ./instructions.md;
  };

  xdg = {
    # Create desktop entry to allow launching via launcher.
    desktopEntries.opencode = {
      name = "Opencode";
      genericName = "AI Coding Assistant";
      exec = let
        terminalCommand = getExe config.xdg.terminal-exec.package;
        opencode = getExe' config.programs.opencode.package "opencode";
      in "${terminalCommand} --title=Opencode ${opencode}";
      categories = [
        "Development"
        "Utility"
      ];
    };
  };
}
