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
    ;
  inherit (pkgs.stdenv.hostPlatform) system;

  # Convert the stylix base16 scheme into a format accepted by nix-userstyles.
  stylixPalette = osConfig.lib.stylix.colors |> filterAttrs (name: _: hasPrefix "base0" name);
in {
  programs.zen-browser.profiles.default = {
    # Remove rounded corners in zen browser interface.
    userChrome = ''
      *,
      *::before,
      *::after {
        border-radius: 0px !important;
      }
    '';

    # Remove rounded corners on sites and apply nix-userstyles themes.
    userContent = ''
      *,
      *::before,
      *::after {
        border-radius: 0px !important;
      }

      ${readFile "${inputs.nix-userstyles.packages.${system}.mkUserStyles stylixPalette [
        # Apply nix-userstyles themes.
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
      ]}"}
    '';
  };
}
