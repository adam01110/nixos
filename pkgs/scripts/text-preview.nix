# SPDX-License-Identifier: AGPL-3.0-or-later
{
  # keep-sorted start
  config,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit (builtins) attrValues;
in
  pkgs.writeShellApplication {
    name = "text-preview";
    runtimeInputs =
      [
        config.programs.bat.package
      ]
      ++ attrValues {
        inherit
          (pkgs)
          # keep-sorted start
          file
          # keep-sorted end
          ;
      };
    text = ''
      path="''${1-}"

      if [ -z "$path" ]; then
        exit 0
      fi

      mime_info=$(file --brief --mime --dereference -- "$path")

      preview_binary() {
        width="''${COLUMNS:-80}"
        height="''${LINES:-80}"
        message="Binary cannot be previewed"
        padding="  $message  "
        blank=""
        line=""
        i=0

        while [ "$i" -lt "$width" ]; do
          line="$line╱"
          i=$((i + 1))
        done

        message_col=$(((width - ''${#padding}) / 2))
        [ "$message_col" -lt 0 ] && message_col=0
        left=""
        i=0
        while [ "$i" -lt "$message_col" ]; do
          left="$left╱"
          i=$((i + 1))
        done

        right_width=$((width - message_col - ''${#padding}))
        [ "$right_width" -lt 0 ] && right_width=0
        right=""
        i=0
        while [ "$i" -lt "$right_width" ]; do
          right="$right╱"
          i=$((i + 1))
        done

        message_line=$((height / 2))
        i=0
        while [ "$i" -lt "$height" ]; do
          if [ "$i" -eq "$((message_line - 1))" ] || [ "$i" -eq "$((message_line + 1))" ]; then
            printf '%s%*s%s\n' "$left" "''${#padding}" "$blank" "$right"
          elif [ "$i" -eq "$message_line" ]; then
            printf '%s%s%s\n' "$left" "$padding" "$right"
          else
            printf '%s\n' "$line"
          fi

          i=$((i + 1))
        done
      }

      if [ "''${mime_info##*charset=}" != "binary" ]; then
        bat -n --color=always -- "$path" || preview_binary
      else
        preview_binary
      fi
    '';
  }
