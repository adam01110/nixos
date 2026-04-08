{
  config,
  lib,
  mcpWrappers,
  pkgs,
  ...
}:
# Configure opencode integration, wrapper, and desktop entry.
let
  inherit (builtins) attrValues;
  inherit
    (lib)
    getExe
    getExe'
    makeBinPath
    ;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (pkgs) symlinkJoin;

  home = config.home.homeDirectory;
in {
  programs.opencode = {
    enable = true;

    # Wrap opencode with mcp's, formatters, and lsp's.
    package = symlinkJoin {
      name = "opencode-wrapped";
      paths = [pkgs.nur.repos.adam0.opencode];
      nativeBuildInputs = [pkgs.makeWrapper];

      # Source plugin credentials before launching the wrapped binary.
      postBuild = ''
        wrapProgram $out/bin/opencode \
          --prefix PATH : ${makeBinPath (attrValues {
          inherit (pkgs.nur.repos.adam0) modular-mcp;
          inherit
            (mcpWrappers)
            context7McpWrapper
            githubMcpServerWrapper
            ;
          inherit
            (pkgs)
            wl-clipboard
            libnotify
            # Lsp's.
            lua-language-server
            bash-language-server
            yaml-language-server
            vscode-json-languageserver
            ty
            oxlint
            taplo
            typescript-language-server
            rust-analyzer
            # Formatters.
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
    # Point opencode at the shared agent skills directory.
    configFile."opencode/skills".source = mkOutOfStoreSymlink "${home}/.agents/skills";

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
