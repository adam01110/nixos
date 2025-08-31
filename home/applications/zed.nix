{
  config,
  lib,
  pkgs,
  username,
  ...
}:

{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "biome"
      "discord-presence"
      "html"
      "nix"
      "qml"
      "ruff"
      "toml"
    ];

    extraPackages = with pkgs; [
      # packages for nix
      nixd
      nixfmt

      # packages for rust
      rust-analyzer

      # packages for qml
      kdePackages.qtdeclarative
    ];

    userSettings = {
      # disable telemetry
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      auto_update = false;

      cursor_shape = "block";

      # minimap scrollbar
      scrollbar.axes.vertical = false;
      minimap = {
        show = "always";
        thumb_border = "none";
        current_line_highlight = "line";
      };

      inlay_hints.enabled = true;

      languages = {
        Nix = {
          # use nixd lsp for nix
          language_servers = [
            "nixd"
            "!nil"
          ];
          # use nixfmt formatter for nix
          formatter.external.command = "nixfmt";
        };

        Python = {
          language_servers = [
            "pyright"
            "ruff"
          ];
          formatter.code_actions = {
            "source.fixAll.ruff" = true;
            "source.organizeImports.ruff" = true;
          };
        };

        # enable biome formatter and linter for supported languages
        Javascript.formatter.language_server.name = "biome";
        TypeScript.formatter.language_server.name = "biome";
        TSX.formatter.language_server.name = "biome";
        JSON.formatter.language_server.name = "biome";
        JSONC.formatter.language_server.name = "biome";
        CSS.formatter.language_server.name = "biome";
      };
    };

    lsp.discord_presence.initialization_options.git_integration = true;
  };

  home.sessionVariables = {
    EDITOR = "zeditor";
    VISUAL = "zeditor";
  };
}
