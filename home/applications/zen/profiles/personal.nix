{
  pkgs,
  username,
  commonExtensions,
  commonSearchEngines,
  ...
}:

let
  inherit (builtins) attrValues;
  nixIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
in
{
  "${username}" = {
    extensions = {
      force = true;
      packages =
        commonExtensions
        ++ attrValues {
          inherit (pkgs.nur.repos.rycee.firefox-addons)
            modrinthify
            proton-vpn
            ;
        };
    };

    search = {
      force = true;
      default = "brave";
      engines = commonSearchEngines // {
        # nix
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
              template = "https://searchix.ovh/options/nixos/";
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
              template = "https://searchix.ovh/options/home-manager/";
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
              template = "https://searchix.ovh/packages/nixpkgs/";
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
              template = "https://searchix.ovh/packages/nur/";
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

        # wiki
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

        # dev
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
  };
}
