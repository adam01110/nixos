{
  config,
  lib,
  pkgs,
  ...
}:
# Configure zed editor.
let
  inherit (builtins) attrValues;
  inherit
    (lib)
    mkEnableOption
    mkIf
    getExe
    ;
in {
  # Vm option enables gpu acceleration for virtual machine environments.
  options.zed.isVm = mkEnableOption "Allow the usage of virtio gpu accel";

  config = {
    programs = {
      zed-editor = {
        enable = true;

        # Add packages for language servers and formatters.
        extraPackages = attrValues {
          inherit
            (pkgs)
            # Packages for nix.
            nixd
            alejandra
            # Packages for rust.
            rust-analyzer
            # Packages for shell script.
            shfmt
            # Packages for bash.
            shellcheck
            # Packages for lua.
            stylua
            ;

          # Packages for qml.
          inherit (pkgs.kdePackages) qtdeclarative;
        };

        # Configure editor behavior and language settings.
        userSettings = {
          # Disable telemetry.
          telemetry = {
            diagnostics = false;
            metrics = false;
          };

          auto_update = false;

          cursor_shape = "block";

          # Minimap scrollbar.
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
              # Use nixd lsp for nix.
              language_servers = ["nixd"];
              # Use alejandra formatter for nix.
              formatter.external.command = getExe pkgs.alejandra;
            };

            Python.language_servers = [
              "ty"
              "!basedpyright"
              "..."
            ];

            "Shell Script".formatter.external = {
              command = getExe pkgs.shfmt;
              arguments = [
                "--filename"
                "{buffer_path}"
                "--indent"
                "2"
              ];
            };

            Lua.formatter.external = {
              command = getExe pkgs.stylua;
              arguments = [
                "--respect-ignores"
                "--stdin-filepath"
                "{buffer_path}"
                "-"
              ];
            };

            JavaScript.formatter.language_server.name = "oxc";
            TypeScript = {
              prettier.allowed = false;
              formatter.language_server.name = "oxc";
            };
            TSX.formatter.language_server.name = "oxc";
            JSON.formatter.language_server.name = "oxc";

            JSONC.formatter.language_server.name = "biome";
            CSS.formatter.language_server.name = "biome";
          };

          lsp = {
            # Enable git integration for discord rpc.
            discord_presence.initialization_options.git_integration = true;

            # Enable tailwind css in typescript and javascript.
            tailwindcss-language-server.settings.experimental.classRegex = [
              "\\.className\\s*[+]?=\\s*['\"]([^'\"]*)['\"]"
              "\\.setAttributeNS\\(.*,\\s*['\"]class['\"],\\s*['\"]([^'\"]*)['\"]"
              "\\.setAttribute\\(['\"]class['\"],\\s*['\"]([^'\"]*)['\"]"
              "\\.classList\\.add\\(['\"]([^'\"]*)['\"]"
              "\\.classList\\.remove\\(['\"]([^'\"]*)['\"]"
              "\\.classList\\.toggle\\(['\"]([^'\"]*)['\"]"
              "\\.classList\\.contains\\(['\"]([^'\"]*)['\"]"
              "\\.classList\\.replace\\(\\s*['\"]([^'\"]*)['\"]"
              "\\.classList\\.replace\\([^,)]+,\\s*['\"]([^'\"]*)['\"]"
            ];

            # Enable path lookup.
            rust-analyzer.binary.path_lookup = true;
            nix.binary.path_lookup = true;
          };
        };
      };

      # Install extensions for zed with nix packages.
      zed-editor-extensions = {
        enable = true;
        packages = attrValues {
          inherit
            (pkgs.zed-extensions)
            basher
            biome
            color-highlight
            discord-presence
            docker-compose
            dockerfile
            git-firefly
            html
            lua
            nix
            oxc
            qml
            toml
            tombi
            xml
            ;
        };
      };
    };

    # Export zed session variables.
    home.sessionVariables = mkIf config.zed.isVm {ZED_ALLOW_EMULATED_GPU = "1";};
  };
}
