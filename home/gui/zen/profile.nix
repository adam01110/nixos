{
  osConfig,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

# default zen profile with shared search engines and extensions.
let
  inherit (builtins)
    attrValues
    readFile
    ;
  inherit (lib)
    filterAttrs
    hasPrefix
    ;

  nixIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";

  # convert the stylix base16 scheme into a format accepted by nix-userstyles.
  stylixPalette =
    osConfig.lib.stylix.colors
    |> filterAttrs (name: _: hasPrefix "base0" name);
in
{
  programs.zen-browser.profiles.default = {
    # set extensions.
    extensions = {
      force = true;
      packages = attrValues {
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
          modrinthify
          proton-vpn
          indie-wiki-buddy
          ;
      };
    };

    # set search engines.
    search = {
      force = true;
      default = "brave";
      engines = {
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

        # nix.
        nix = {
          urls = [
            {
              template = "https://searchix.ovh/";
              params = [
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = nixIcon;
          definedAliases = [ "@n" ];
        };
        nixos = {
          urls = [
            {
              template = "https://searchix.ovh/options/nixos/search";
              params = [
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = nixIcon;
          definedAliases = [ "@no" ];
        };
        "home-manager" = {
          urls = [
            {
              template = "https://searchix.ovh/options/home-manager/search";
              params = [
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = nixIcon;
          definedAliases = [ "@hm" ];
        };
        "nix-packages" = {
          urls = [
            {
              template = "https://searchix.ovh/packages/nixpkgs/search";
              params = [
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = nixIcon;
          definedAliases = [ "@np" ];
        };
        nur = {
          urls = [
            {
              template = "https://searchix.ovh/packages/nur/search";
              params = [
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = nixIcon;
          definedAliases = [ "@nu" ];
        };

        # wiki.
        "nixos-wiki" = {
          urls = [
            {
              template = "https://wiki.nixos.org/w/index.php";
              params = [
                {
                  name = "search";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = nixIcon;
          definedAliases = [ "@nw" ];
        };
        "arch-wiki" = {
          urls = [
            {
              template = "https://wiki.archlinux.org/index.php";
              params = [
                {
                  name = "search";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          icon = nixIcon;
          definedAliases = [ "@aw" ];
        };
        "minecraft-wiki" = {
          urls = [
            {
              template = "https://minecraft.wiki/";
              params = [
                {
                  name = "search";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          iconMapObj."16" = "https://minecraft.wiki/favicon.ico";
          definedAliases = [ "@mw" ];
        };

        # dev.
        crates = {
          urls = [
            {
              template = "https://crates.io/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          iconMapObj."16" = "https://crates.io/favicon.ico";
          definedAliases = [ "@c" ];
        };
        dockerhub = {
          urls = [
            {
              template = "https://hub.docker.com/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
              ];
            }
          ];
          iconMapObj."16" = "https://www.docker.com/favicon.ico";
          definedAliases = [ "@dh" ];
        };
        github = {
          urls = [
            {
              template = "https://github.com/search";
              params = [
                {
                  name = "q";
                  value = "{searchTerms}";
                }
                {
                  name = "type";
                  value = "repositories";
                }
              ];
            }
          ];
          iconMapObj."16" = "https://github.com/favicon.ico";
          definedAliases = [ "@gh" ];
        };
      };
    };

    # set zen spaces.
    spacesForce = true;
    spaces = {
      "general" = {
        id = "29680918-95d2-4162-ba72-1c41bd1b628d";
        position = 1000;
        icon = "🧶";
      };
      "dev" = {
        id = "9b41acc7-1eb2-4c14-9fba-7f6d670db845";
        position = 2000;
        icon = "🖥️";
      };
      "gaming" = {
        id = "70e211cd-676f-4abb-9317-35fac2078913";
        position = 3000;
        icon = "🎮";
      };
      "news" = {
        id = "b2e284cd-b0d6-4d05-9b0a-9021148ff0bb";
        position = 4000;
        icon = "🗞️";
      };
    };

    userContent = ''
      ${readFile "${inputs.nix-userstyles.packages.${system}.mkUserStyles stylixPalette [
        "advent-of-code"
        "alternativeto"
        "arch-wiki"
        "brave-search"
        "bsky"
        "bstats"
        "chatgpt"
        "codeberg"
        "crates.io"
        "dev.to"
        "devdocs"
        "discord"
        "docs.deno.com"
        "docs.rs"
        "freedesktop"
        "ghostty.org"
        "github"
        "gmail"
        "google"
        "google-drive"
        "hacker-news"
        "home-manager-options-search"
        "indie-wiki-buddy"
        "lastfm"
        "linkedin"
        "lobste.rs"
        "mastodon"
        "mdbook"
        "mdn"
        "modrinth"
        "namemc"
        "nitter"
        "neovim.io"
        "nixos-manual"
        "nixos-search"
        "npm"
        "planet-minecraft"
        "porkbun"
        "proton"
        "pypi"
        "react.dev"
        "reddit"
        "rentry.co"
        "searchix"
        "shinigami-eyes"
        "spotify-web"
        "stack-overflow"
        "twitch"
        "web.dev"
        "wiki.nixos.org"
        "wikipedia"
        "wikiwand"
        "youtube"
        "zen-browser-docs"
      ]}"}
    '';
  };
}
