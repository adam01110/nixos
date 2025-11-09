{
  pkgs,
  ...
}:

let
  inherit (builtins) attrValues listToAttrs;
  inherit (pkgs.lib.attrsets) nameValuePair;
  imageAllocMB = 1024;
in
{
  programs.yazi = {
    enable = true;

    initLua = ./init.lua;

    shellWrapperName = "y";

    plugins =
      let
        mkPlugin = name: nameValuePair name pkgs.yaziPlugins.${name};
      in
      listToAttrs (
        (map mkPlugin [
          "full-border"
          "git"
          "mediainfo"
          "smart-enter"
          "smart-paste"
          "starship"
          "piper"
        ])
        ++ [
          {
            name = "ucp";
            value = ./plugins/ucp.yazi;
          }
        ]
      );

    settings = {
      mgr = {
        ratio = [
          1
          2
          2
        ];
        linemode = "size_mtime";
        scrolloff = 10;

        sort_by = "natural";
        sort_translit = true;
        show_hidden = true;
      };

      preview = {
        image_filter = "lanczos3";
        image_quality = 90;

        max_width = 900;
        max_height = 1200;
      };

      plugin = {
        prepend_previewers = [
          # Replace magick, image, video with mediainfo
          {
            mime = "{audio,video,image}/*";
            run = "mediainfo";
          }
          {
            mime = "application/subrip";
            run = "mediainfo";
          }
          # Adobe Illustrator, Adobe Photoshop is image/adobe.photoshop, already handled above
          {
            mime = "application/postscript";
            run = "mediainfo";
          }
          {
            url = "*.md";
            run = "piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dark '$1'";
          }
        ];

        prepend_preloaders = [
          # Replace magick, image, video with mediainfo
          {
            mime = "{audio,video,image}/*";
            run = "mediainfo";
          }
          {
            mime = "application/subrip";
            run = "mediainfo";
          }
          # Adobe Illustrator, Adobe Photoshop is image/adobe.photoshop, already handled above
          {
            mime = "application/postscript";
            run = "mediainfo";
          }
        ];
      };

      tasks.image_alloc = imageAllocMB * 1024 * 1024;
      input.cursor_blink = false;
      which.sort_translit = true;
    };

    keymap.mgr.prepend_keymap = [
      {
        on = "p";
        run = "plugin ucp paste";
        desc = "Paste";
      }
      {
        on = "y";
        run = "plugin ucp copy";
        desc = "Copy";
      }
      {
        on = "p";
        run = "plugin ucp paste notify";
        desc = "Paste";
      }
      {
        on = "y";
        run = "plugin ucp copy notify";
        desc = "Copy";
      }
      {
        on = "p";
        run = "plugin smart-paste";
        desc = "Paste into the hovered directory or CWD";
      }
      {
        on = "<Enter>";
        run = "plugin smart-enter";
        desc = "Enter the child directory, or open the file";
      }
      {
        on = "l";
        run = "plugin smart-enter";
        desc = "Enter the child directory, or open the file";
      }
      {
        on = "<right>";
        run = "plugin smart-enter";
        desc = "Enter the child directory, or open the file";
      }
      {
        on = "L";
        run = "plugin smart-enter";
        desc = "Enter the child directory, or open the file";
      }
    ];
  };

  home.packages = attrValues {
    inherit (pkgs)
      mediainfo
      wl-clipboard
      glow
      ;
  };
}
