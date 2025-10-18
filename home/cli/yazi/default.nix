{
  config,
  lib,
  pkgs,
  ...
}:

let
  imageAllocMB = 1024;
in
{
  programs.yazi = {
    enable = true;

    initLua = "~/init.lua";

    shellWrapperName = "y";

    plugins = {
      full-border = pkgs.yaziPlugins.full-border;
      git = pkgs.yaziPlugins.git;
      mediainfo = pkgs.yaziPlugins.mediainfo;
      starship = pkgs.yaziPlugins.starship;
      smart-paste = pkgs.yaziPlugins.smart-paste;
      smart-enter = pkgs.yaziPlugins.smart-enter;
    };

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
        prepend_fetchers = [
          {
            id = "git";
            name = "*";
            run = "git";
          }
          {
            id = "git";
            name = "*/";
            run = "git";
          }
        ];

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
        on = "y";
        run = "plugin wl-clipboard";
        desc = "Copy selected characters";
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
        on = "<Left>";
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

  home.packages = with pkgs; [
    mediainfo
    wl-clipboard
  ];
}
