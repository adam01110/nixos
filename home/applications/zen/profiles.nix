{
  lib,
  pkgs,
  vars,
  ...
}:

# define zen browser profiles and shared settings.
let
  inherit (builtins) attrValues;
  inherit (lib) foldl';
  inherit (vars) username;

  # extensions shared by all profiles.
  commonExtensions = attrValues {
    inherit (pkgs.nur.repos.rycee.firefox-addons)
      # content blocking.
      ublock-origin
      localcdn
      sponsorblock
      fastforwardteam
      istilldontcareaboutcookies
      consent-o-matic
      don-t-fuck-with-paste

      # annoyances.
      shinigami-eyes
      translate-web-pages
      return-youtube-dislikes
      dearrow

      darkreader
      stylus
      bitwarden
      wikiwand-wikipedia-modernized
      violentmonkey
      pronoundb
      ;
  };

  # custom search engines and aliases.
  commonSearchEngines = {
    # general search.
    brave = {
      urls = [
        {
          template = "https://search.brave.com/search";
          params = [
            {
              name = "q";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      iconMapObj."16" = "https://brave.com/favicon.ico";
      definedAliases = [ "@b" ];
    };
    # add alias to google.
    google.metaData.alias = "@g";

    # wiki.
    wikiwand = {
      urls = [
        {
          template = "https://www.wikiwand.com/en/search";
          params = [
            {
              name = "q";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      iconMapObj."16" = "https://wikiwand.com/favicon.ico";
      definedAliases = [ "@wi" ];
    };

    # other.
    youtube = {
      urls = [
        {
          template = "https://www.youtube.com/results";
          params = [
            {
              name = "search_query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      iconMapObj."16" = "https://www.youtube.com/favicon.ico";
      definedAliases = [ "@yt" ];
    };

    # disabled (hidden)
    bing.metaData.hidden = true;
    ddg.metaData.hidden = true;
    qwant.metaData.hidden = true;
    ecosia.metaData.hidden = true;
  };

  # arguments passed into each profile module.
  profileArgs = {
    inherit
      pkgs
      username
      commonExtensions
      commonSearchEngines
      ;
  };

  # list of profile modules to merge.
  profileFiles = [
    ./profiles/personal.nix
    ./profiles/academia.nix
  ];

  # merge all profiles into a single attribute set.
  mergedProfiles = foldl' (acc: file: acc // (import file profileArgs)) { } profileFiles;
in
{
  # set the profiles in zen browser.
  programs.zen-browser.profiles = mergedProfiles;
}
