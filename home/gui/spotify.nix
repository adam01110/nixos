{
  pkgs,
  inputs,
  system,
  ...
}:
# configure spicetify.
let
  inherit (builtins) attrValues;
in {
  programs.spicetify = let
    # access spicetify-nix packages.
    spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
  in {
    enable = true;

    # turn on experimental features, use wayland, and apply wm patch.
    experimentalFeatures = true;
    windowManagerPatch = true;
    wayland = true;

    # enable extensions.
    enabledExtensions = let
      # extensions not packaaged in spicetify-nix.
      volumePercentageSrc = pkgs.fetchFromGitHub {
        owner = "jeroentvb";
        repo = "spicetify-volume-percentage";
        rev = "030c36b8903a99fa06405dae65b66fa4910eff99";
        hash = "sha256-UM+8dX4OeaxmZ99sjGF7uJhAoRdhxTqgXU5F3FOlUU4=";
      };
      moreLyricsSrc = pkgs.fetchFromGitHub {
        owner = "Kamiloo13";
        repo = "spicetify-extensions";
        rev = "bfad7427ef6385a27cdb7a9e3b2851a76702b896";
        hash = "sha256-hFjPE4zUPV6qnw/FWc1TG1l2gPdPFa+umBlF3A+2DnM=";
      };
      cacheCleanerSrc = pkgs.fetchFromGitHub {
        owner = "kyrie25";
        repo = "Spicetify-Cache-Cleaner";
        rev = "8d0ec54581920629734acc5e4449d34d6afce7fb";
        hash = "sha256-VuBbW4xYpB2QbSsNjR1an05WMXhLU9rv9moHw/DgCgk=";
      };
      SpotifyPlaylistIconsSrc = pkgs.fetchFromGitHub {
        owner = "jeroentvb";
        repo = "spicetify-playlist-icons";
        rev = "dist";
        hash = "sha256-hOkFIAperiWzfR+EVVAxEdta9LRndJbjritMj4I0gNw=";
      };
    in
      # extensions from spicetify-nix.
      (attrValues {
        inherit
          (spicePkgs.extensions)
          keyboardShortcut
          seekSong
          fullAlbumDate
          goToSong
          listPlaylistsWithSong
          wikify
          betterGenres
          lastfm
          copyLyrics
          playingSource
          sectionMarker
          queueTime
          aiBandBlocker
          ;
      })
      # custom extensions fetched above.
      ++ [
        {
          src = volumePercentageSrc;
          name = "volumePercentage.js";
        }
        {
          src = "${moreLyricsSrc}/extensions/more-lyrics/dist";
          name = "more-lyrics.js";
        }
        {
          src = cacheCleanerSrc;
          name = "cacheCleaner.js";
        }
        {
          src = SpotifyPlaylistIconsSrc;
          name = "playlist-icons.js";
        }
      ];

    # enable css snippets.
    enabledSnippets = attrValues {
      inherit
        (spicePkgs.snippets)
        pointer
        removeTheArtistsAndCreditsSectionsFromTheSidebar
        ;
    };
  };
}
