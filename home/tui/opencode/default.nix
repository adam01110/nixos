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
  inherit (lib) getExe';
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

    package = symlinkJoin {
      name = "opencode-wrapped";
      paths =
        [inputs.llm-agents.packages.${system}.opencode]
        ++ attrValues {
          inherit (pkgs.nur.repos.adam0) modular-mcp;
          inherit
            (pkgs)
            # lsp
            lua-language-server
            bash-language-server
            yaml-language-server
            vscode-json-languageserver
            ty
            oxlint
            taplo
            typescript-language-server
            rust-analyzer
            # formatter
            alejandra
            fish
            stylua
            shfmt
            oxfmt
            ruff
            rustfmt
            ;
        };
    };

    rules = ./instructions.md;
  };

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

  stylix.targets.opencode.enable = true;
}
