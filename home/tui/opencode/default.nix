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
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  imports = [
    ./formatter.nix
    ./lsp.nix
    ./settings.nix
  ];

  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;

    package = symlinkJoin {
      name = "opencode-wrapped";
      paths = with inputs;
        [
          llm-agents.packages.${system}.opencode
          # mcp
          mcp-nix.packages.${system}.default
          mcp-servers-nix.packages.${system}.context7-mcp
        ]
        ++ attrValues {
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
      "DISABLE_COPY_ON_SELECT"
      "FILEWATCHER"
      "LSP_TY"
      "OXFMT"
    ];
    disabledFeatures = ["LSP_DOWNLOAD"];
  in
    mkEnv "OPENCODE_EXPERIMENTAL" experimentalFeatures
    // mkEnv "OPENCODE_DISABLE" disabledFeatures;

  xdg = {
    # put the auth json where opencode expects it.
    dataFile."opencode/auth.json".source = mkOutOfStoreSymlink config.sops.templates."openrouter_key".path;

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
