{
  # keep-sorted start
  lib,
  pkgs,
  # keep-sorted end
  ...
}:
# Configure opencode lsp commands by extension.
let
  inherit (lib) getExe;
in {
  programs.opencode.settings.lsp = {
    # keep-sorted start block=yes newline_separated=yes
    bash = {
      command = [(getExe pkgs.bash-language-server) "start"];
      extensions = [".sh" ".bash"];
    };

    json = {
      command = [(getExe pkgs.vscode-json-languageserver) "--stdio"];
      extensions = [".json" ".jsonc"];
    };

    lua = {
      command = [(getExe pkgs.lua-language-server)];
      extensions = [".lua"];
    };

    nixd = {
      command = [(getExe pkgs.nixd)];
      extensions = [".nix"];
    };

    oxlint = {
      command = [(getExe pkgs.oxlint)];
      extensions = [".ts" ".tsx" ".js" ".jsx"];
    };

    rust = {
      command = [(getExe pkgs.rust-analyzer)];
      extensions = [".rs"];
    };

    taplo = {
      command = [(getExe pkgs.taplo) "lsp" "stdio"];
      extensions = [".toml"];
    };

    ty = {
      command = [(getExe pkgs.ty)];
      extensions = [".py" ".pyi"];
    };

    typescript = {
      command = [(getExe pkgs.typescript-language-server) "--stdio"];
      extensions = [".ts" ".tsx" ".js" ".jsx"];
    };

    yaml-ls = {
      command = [(getExe pkgs.yaml-language-server) "--stdio"];
      extensions = [".yaml" ".yml"];
    };
    # keep-sorted end
  };
}
