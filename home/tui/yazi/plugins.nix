{pkgs, ...}: let
  inherit (builtins) listToAttrs;
  inherit (pkgs.lib.attrsets) nameValuePair;
in {

  # yazi plugin set and keybindings.
  programs.yazi = {
    plugins = let
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
        # ucp is not in nixpkgs yet.
        ++ [
          {
            name = "ucp";
            value = ./plugins/ucp.yazi;
          }
        ]
      );

    # use mediainfo for rich previews and piper with glow for markdown.
    settings.plugin = {
      prepend_previewers = [
        # replace magick, image, video with mediainfo.
        {
          mime = "{audio,video,image}/*";
          run = "mediainfo";
        }
        {
          mime = "application/subrip";
          run = "mediainfo";
        }
        # adobe illustrator, adobe photoshop is image/adobe.photoshop, already handled above.
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
        # replace magick, image, video with mediainfo.
        {
          mime = "{audio,video,image}/*";
          run = "mediainfo";
        }
        {
          mime = "application/subrip";
          run = "mediainfo";
        }
        # adobe illustrator, adobe photoshop is image/adobe.photoshop, already handled above.
        {
          mime = "application/postscript";
          run = "mediainfo";
        }
      ];
    };

    # define keybindings for copy, paste, and smart actions.
    keymap.mgr.prepend_keymap = [
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
    ];
  };
}
