{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    optionalAttrs;

  configHome = config.xdg.configHome;
  cacheHome = config.xdg.stateHome;
in
{
  options.zed.isVm = mkEnableOption "Allow the usage of virtio gpu accel";

  config = {
    programs.zed-editor = {
      enable = true;

      extensions = [
        "biome"
        "color-highlight"
        "discord-presence"
        "git-firefly"
        "html"
        "lua"
        "nix"
        "qml"
        "toml"
      ];

      extraPackages = with pkgs; [
        # packages for nix
        nixd
        nixfmt

        # packages for qml
        kdePackages.qtdeclarative

        # packages for rust
        rust-analyzer

        # packages for lua
        stylua
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
        lsp_document_colors = "background";
        minimap = {
          show = "always";
          thumb_border = "none";
          current_line_highlight = "line";
        };

        inlay_hints.enabled = true;
        show_edit_predictions = false;

        languages = {
          Nix = {
            # use nixd lsp for nix
            language_servers = [ "nixd" ];
            # use nixfmt formatter for nix
            formatter.external.command = "nixfmt";
          };

          Python = {
            language_servers = [
              "ty"
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

          Lua.formatter.external = {
            command = "stylua";
            arguments = [
              "--syntax=Lua54"
              "--respect-ignores"
              "--stdin-filepath"
              "{buffer_path}"
              "-"
            ];
          };
        };

        lsp.discord_presence.initialization_options.git_integration = true;
      };
    };

    home.sessionVariables =
      let
        cfgVm = config.zed.isVm;

        name = "zeditor";
      in
      {
        EDITOR = name;
        VISUAL = name;

        BIOME_CONFIG_PATH = "${configHome}/biome/biome.json";
        RUFF_CACHE_DIR = "${cacheHome}/ruff";
      }
      // optionalAttrs cfgVm { ZED_ALLOW_EMULATED_GPU = "1"; };
  };
}
