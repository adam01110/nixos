{
  config,
  lib,
  pkgs,
  ...
}:
# configure zed editor.
let
  inherit (builtins) attrValues;
  inherit
    (lib)
    mkEnableOption
    optionalAttrs
    getExe
    ;
in {
  options.zed.isVm = mkEnableOption "Allow the usage of virtio gpu accel";

  config = {
    programs = {
      zed-editor = {
        enable = true;

        # add packages for language servers and formatters.
        extraPackages = attrValues {
          inherit
            (pkgs)
            # packages for nix.
            nixd
            alejandra
            # packages for rust.
            rust-analyzer
            # packages for shell script.
            shfmt
            # packages for bash.
            shellcheck
            # packages for lua.
            stylua
            ;

          # packages for qml.
          inherit (pkgs.kdePackages) qtdeclarative;
        };

        # configure editor behavior and language settings.
        userSettings = {
          # disable telemetry.
          telemetry = {
            diagnostics = false;
            metrics = false;
          };

          auto_update = false;

          cursor_shape = "block";

          # minimap scrollbar.
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
              # use nixd lsp for nix.
              language_servers = ["nixd"];
              # use nixfmt formatter for nix.
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
            # enable git integration for discord rpc.
            discord_presence.initialization_options.git_integration = true;

            # enable tailwind css in typescript and javascript.
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

            # enable path lookup.
            rust-analyzer.binary.path_lookup = true;
            nix.binary.path_lookup = true;
          };
        };
      };

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

    # export editor-related session variables.
    home.sessionVariables = let
      cfgVm = config.zed.isVm;

      name = "zeditor";
    in
      {
        # ZED
        EDITOR = name;
        VISUAL = name;
      }
      // optionalAttrs cfgVm {ZED_ALLOW_EMULATED_GPU = "1";};
  };
}
