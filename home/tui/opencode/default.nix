{
  config,
  lib,
  inputs,
  pkgs,
  system,
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
  imports = [
    ./mcp
    ./formatter.nix
    ./lsp.nix
    ./settings.nix
  ];

  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;

    # wrap opencode with mcp's, formatters, and lsp's.
    package = symlinkJoin {
      name = "opencode-wrapped";
      paths = [inputs.llm-agents.packages.${system}.opencode];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/opencode \
          --prefix PATH : ${makeBinPath (attrValues {
          inherit (pkgs.nur.repos.adam0) modular-mcp;
          inherit
            (pkgs)
            # lsp's
            lua-language-server
            bash-language-server
            yaml-language-server
            vscode-json-languageserver
            ty
            oxlint
            taplo
            typescript-language-server
            rust-analyzer
            # formatters
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

    # set agent rules.
    rules = ./instructions.md;
  };

  # set env vars for eperimental features and disabled features.
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
    # create desktop entry to allow launching via launcher.
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
