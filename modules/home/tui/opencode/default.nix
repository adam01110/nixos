{
  # keep-sorted start
  config,
  lib,
  mcpWrappers,
  opencodeEnv,
  pkgs,
  # keep-sorted end
  ...
}:
# Configure opencode integration, wrapper, and desktop entry.
let
  inherit (builtins) attrValues;
  inherit
    (lib)
    # keep-sorted start
    concatStringsSep
    escapeShellArg
    getExe
    getExe'
    makeBinPath
    mapAttrsToList
    # keep-sorted end
    ;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (pkgs) symlinkJoin;

  home = config.home.homeDirectory;
  wrapEnvArgs = concatStringsSep " \\" (
    mapAttrsToList
    (name: value: "--set ${escapeShellArg name} ${escapeShellArg (toString value)}")
    opencodeEnv
  );
in {
  programs.opencode = {
    enable = true;

    # Wrap opencode with mcp's, formatters, and lsp's.
    package = symlinkJoin {
      name = "opencode-wrapped";
      paths = [pkgs.nur.repos.adam0.opencode];
      nativeBuildInputs = [pkgs.makeWrapper];

      # Set feature flags and prepend runtime tools before launching opencode.
      postBuild = ''
        wrapProgram $out/bin/opencode \
          ${wrapEnvArgs} \
          --prefix PATH : ${makeBinPath (attrValues {
          inherit (pkgs.nur.repos.adam0) modular-mcp;
          inherit
            (mcpWrappers)
            # keep-sorted start
            context7McpWrapper
            githubMcpServerWrapper
            # keep-sorted end
            ;
          inherit
            (pkgs)
            # keep-sorted start
            libnotify
            wl-clipboard
            # keep-sorted end
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
        # keep-sorted start
        opencode = getExe' config.programs.opencode.package "opencode";
        terminalCommand = getExe config.xdg.terminal-exec.package;
        # keep-sorted end
      in "${terminalCommand} --title=Opencode ${opencode}";

      categories = [
        # keep-sorted start
        "ConsoleOnly"
        "Development"
        # keep-sorted end
      ];
    };
  };
}
