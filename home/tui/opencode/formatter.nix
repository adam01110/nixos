{
  lib,
  pkgs,
  ...
}: let
  inherit
    (lib)
    getExe
    getExe'
    ;
in {
  programs.opencode.settings.formatter = {
    alejandra = {
      command = [(getExe pkgs.alejandra)];
      extensions = [".nix"];
    };

    stylua = {
      command = [(getExe pkgs.stylua) "--respect-ignores" "-"];
      extensions = [".lua"];
    };

    shfmt = {
      command = [(getExe pkgs.shfmt)];
      extensions = [".sh" ".bash"];
    };

    fish_indent = {
      command = [(getExe' pkgs.fish "fish_indent")];
      extensions = [".fish"];
    };

    oxfmt = {
      command = [(getExe pkgs.oxfmt)];
      extensions = [
        ".yaml"
        ".yml"
        ".js"
        ".json"
        ".jsx"
        ".md"
        ".ts"
        ".tsx"
        ".css"
        ".html"
      ];
    };

    ruff = {
      command = [(getExe pkgs.ruff)];
      extensions = [".py" ".pyi"];
    };

    rustfmt = {
      command = [(getExe pkgs.rustfmt) "$FILE"];
      extensions = [".rs"];
    };
  };
}
