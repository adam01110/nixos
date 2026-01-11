{pkgs, ...}:
# zen browser search engine configuration.
{
  programs.zen-browser.profiles.default = {
    search = {
      force = true;
      default = "brave";
      engines = let
        nixIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      in {
        # general search engines.
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
          definedAliases = ["@b"];
        };
        google.metaData.alias = "@g";

        # wiki search engines.
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
          definedAliases = ["@wi"];
        };

        # media search engines.
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
          definedAliases = ["@yt"];
        };

        # disabled (hidden)
        bing.metaData.hidden = true;
        ddg.metaData.hidden = true;
        qwant.metaData.hidden = true;
        ecosia.metaData.hidden = true;

        # nix related search engines.
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
          definedAliases = ["@n"];
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
          definedAliases = ["@no"];
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
          definedAliases = ["@hm"];
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
          definedAliases = ["@np"];
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
          definedAliases = ["@nu"];
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
          definedAliases = ["@nw"];
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
          definedAliases = ["@aw"];
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
          definedAliases = ["@mw"];
        };

        # development resources.
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
          definedAliases = ["@c"];
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
          definedAliases = ["@dh"];
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
          definedAliases = ["@gh"];
        };
      };
    };
  };
}
