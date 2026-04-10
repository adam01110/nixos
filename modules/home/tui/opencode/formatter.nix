{
  # keep-sorted start
  lib,
  pkgs,
  # keep-sorted end
  ...
}:
# Configure opencode formatter commands by file extension.
let
  inherit
    (lib)
    # keep-sorted start
    getExe
    getExe'
    # keep-sorted end
    ;
in {
  programs.opencode.settings.formatter = {
    # keep-sorted start block=yes newline_separated=yes
    alejandra = {
      command = [(getExe pkgs.alejandra) "$FILE"];
      extensions = [".nix"];
    };

    fish_indent = {
      command = [(getExe' pkgs.fish "fish_indent")];
      extensions = [".fish"];
    };

    biome = {
      command = [(getExe pkgs.biome)];
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

    shfmt = {
      command = [(getExe pkgs.shfmt)];
      extensions = [".sh" ".bash"];
    };

    stylua = {
      command = [(getExe pkgs.stylua) "--respect-ignores" "-"];
      extensions = [".lua"];
    };
    # keep-sorted end
  };
}
