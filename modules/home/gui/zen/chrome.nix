{
  osConfig,
  lib,
  inputs,
  pkgs,
  ...
}:
# Zen browser user chrome and content styling with nix-userstyles integration.
let
  inherit (builtins) readFile;
  inherit
    (lib)
    filterAttrs
    hasPrefix
    mkAfter
    ;
  inherit (pkgs.stdenv.hostPlatform) system;

  # Convert the stylix base16 scheme into a format accepted by nix-userstyles.
  palette = filterAttrs (name: _: hasPrefix "base0" name) osConfig.lib.stylix.colors;
in {
  # Remove rounded corners in zen browser interface.
  programs.zen-browser.profiles.default = {
    userChrome = ''
      *,
      *::before,
      *::after {
        border-radius: 0px !important;
      }
    '';

    # Append generated site styles after profile content overrides.
    userContent = mkAfter (
      readFile (inputs.nix-userstyles.lib.mkUserContent system {
        inherit palette;

        # Apply nix-userstyles themes.
        userStyles = [
          "advent-of-code"
          "alternativeto"
          "anonymous-overflow"
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
          "regex101"
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
        ];

        # Remove rounded corners on sites and apply nix-userstyles themes.
        extraCss = ''
          *,
          *::before,
          *::after {
            border-radius: 0px !important;
          }
        '';
      })
    );
  };
}
