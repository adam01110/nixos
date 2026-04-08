{
  pkgs,
  inputs,
  ...
}:
# Configure spicetify.
let
  inherit (builtins) attrValues;
  inherit (pkgs.stdenv.hostPlatform) system;
in {
  programs.spicetify = let
    # Access spicetify-nix packages.
    spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
  in {
    enable = true;

    # Turn on experimental features, use wayland, and apply wm patch.
    experimentalFeatures = true;
    windowManagerPatch = true;
    wayland = true;

    # Enable extensions.
    enabledExtensions = attrValues {
      # Extensions from spicetify-nix.
      inherit
        (spicePkgs.extensions)
        keyboardShortcut
        seekSong
        fullAlbumDate
        goToSong
        listPlaylistsWithSong
        wikify
        betterGenres
        copyLyrics
        playingSource
        sectionMarker
        queueTime
        aiBandBlocker
        ;

      # Extensions from adam0's nur.
      inherit
        (pkgs.nur.repos.adam0.spicetifyExtensions)
        volumePercentage
        moreLyrics
        playlistIcons
        ;
    };

    # Enable css snippets.
    enabledSnippets = attrValues {
      inherit
        (spicePkgs.snippets)
        pointer
        removeTheArtistsAndCreditsSectionsFromTheSidebar
        smoothProgressBar
        ;
    };
  };
}
