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
    ./formatter.nix
    ./lsp.nix
    ./mcp.nix
    ./settings.nix
  ];

  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;

    package = symlinkJoin {
      name = "opencode-wrapped";
      paths = let
        mcp-servers-nix = inputs.mcp-servers-nix.packages.${system};
      in
        with inputs;
          [
            llm-agents.packages.${system}.opencode
            #mcp
            mcp-nixos.packages.${system}.mcp-nixos
          ]
          ++ attrValues {
            inherit
              (mcp-servers-nix)
              # mcp
              context7-mcp
              mcp-server-git
              ;

            inherit
              (pkgs)
              # mcp
              github-mcp-server
              # lsp
              lua-language-server
              bash-language-server
              yaml-language-server
              vscode-json-languageserver
              ty
              oxlint
              taplo
              typescript-language-server
              # formatter
              alejandra
              fish
              stylua
              shfmt
              oxfmt
              ruff
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
