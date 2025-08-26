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
      "html"
      "nix"
      "toml"
      "biome"
      "discord-presence"
      "qml"
    ];

    extraPackages = [
      # packages for nix
      pkgs.nixd
      pkgs.nixfmt

      # packages for rust
      pkgs.rust-analyzer
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
