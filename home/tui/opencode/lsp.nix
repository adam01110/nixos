{
  lib,
  pkgs,
  ...
}:
# Configure opencode lsp commands by extension.
let
  inherit (lib) getExe;
in {
  programs.opencode.settings.lsp = {
    nixd = {
      command = [(getExe pkgs.nixd)];
      extensions = [".nix"];
    };

    lua = {
      command = [(getExe pkgs.lua-language-server)];
      extensions = [".lua"];
    };

    bash = {
      command = [(getExe pkgs.bash-language-server) "start"];
      extensions = [".sh" ".bash"];
    };

    yaml-ls = {
      command = [(getExe pkgs.yaml-language-server) "--stdio"];
      extensions = [".yaml" ".yml"];
    };

    json = {
      command = [(getExe pkgs.vscode-json-languageserver) "--stdio"];
      extensions = [".json" ".jsonc"];
    };

    ty = {
      command = [(getExe pkgs.ty)];
      extensions = [".py" ".pyi"];
    };

    oxlint = {
      command = [(getExe pkgs.oxlint)];
      extensions = [".ts" ".tsx" ".js" ".jsx"];
    };

    taplo = {
      command = [(getExe pkgs.taplo) "lsp" "stdio"];
      extensions = [".toml"];
    };

    typescript = {
      command = [(getExe pkgs.typescript-language-server) "--stdio"];
      extensions = [".ts" ".tsx" ".js" ".jsx"];
    };

    rust = {
      command = [(getExe pkgs.rust-analyzer)];
      extensions = [".rs"];
    };
  };
}
