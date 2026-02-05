{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit
    (builtins)
    attrValues
    listToAttrs
    ;
  inherit
    (lib)
    getExe'
    makeBinPath
    ;
  inherit (pkgs) symlinkJoin;
in {
  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;

    # Wrap opencode with mcp's, formatters, and lsp's.
    package = symlinkJoin {
      name = "opencode-wrapped";
      paths = [pkgs.opencode];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/opencode \
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
            fish
            stylua
            shfmt
            oxfmt
            ruff
            rustfmt
            ;
        })}
      '';
    };

    # Set agent rules.
    rules = ./instructions.md;
  };

  # Set env vars for eperimental features and disabled features.
  home.sessionVariables = let
    mkEnv = prefix: features:
      listToAttrs (
        map (n: {
          name = "${prefix}_${n}";
          value = 1;
        })
        features
      );

    experimentalFeatures = [
      "ICON_DISCOVERY"
      "FILEWATCHER"
      "LSP_TY"
      "OXFMT"
    ];
    disabledFeatures = ["LSP_DOWNLOAD"];
  in
    mkEnv "OPENCODE_EXPERIMENTAL" experimentalFeatures
    // mkEnv "OPENCODE_DISABLE" disabledFeatures;

  xdg = {
    # Create desktop entry to allow launching via launcher.
    desktopEntries.opencode = {
      name = "Opencode";
      genericName = "AI Coding Assistant";
      exec = getExe' config.programs.opencode.package "opencode";
      terminal = true;
      categories = [
        "Development"
        "Utility"
      ];
    };
  };
}
