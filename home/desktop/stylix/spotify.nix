{
  pkgs,
  osConfig,
  inputs,
  ...
}:
# Apply stylix overrides for spicetify.
let
  inherit (osConfig.lib.stylix) colors;
  inherit (pkgs.stdenv.hostPlatform) system;

  font = osConfig.stylix.fonts.monospace.name;
in {
  programs.spicetify = {
    theme = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
    in {
      name = "stylix";
      inherit (spicePkgs.themes.text) src;
      sidebarConfig = false;

      # Set font to stylix font.
      # Force the text theme to show all images.
      # Disable border highlight animations and fades.
      # Remove rounded corners from all elements for consistent styling.
      # Remove the ugly spotify-tui header.
      additionalCss = ''
        :root {
          --font-family: '${font}', monospace;

          --display-card-image: block;
          --display-coverart-image: block;
          --display-header-image: block;
          --display-sidebar-image: block;
          --display-tracklist-image: block;
          --border-transition: 0s;
        }

        .Root__globalNav,
        .main-yourLibraryX-entryPoints,
        .Root__main-view,
        .main-nowPlayingBar-container,
        .Root__right-sidebar:has(aside:not(:empty)) {
          transition: none !important;
        }

        .Root__globalNav::before,
        .Root__nav-bar .main-yourLibraryX-entryPoints::before,
        .Root__main-view::before,
        .main-nowPlayingBar-container::before,
        .Root__right-sidebar:has(aside:not(:empty))::before {
          transition: none !important;
        }

        .player-controls__buttons,
        .main-nowPlayingBar-extraControls,
        .main-connectBar-connectBar {
          opacity: 1 !important;
          transition: none !important;
        }

        *,
        *::before,
        *::after {
          border-radius: 0px !important;
        }

        .view-homeShortcutsGrid-shortcuts::before {
          content: "" !important;
        }
      '';
    };

    colorScheme = "custom";
    customColorScheme = with colors; {
      text = base05;
      subtext = base05;
      main = base00;
      main-elevated = base02;
      highlight = base02;
      highlight-elevated = base03;
      sidebar = base01;
      player = base04;
      card = base03;
      shadow = base00;
      selected-row = base04;
      button = base04;
      button-active = base04;
      button-disabled = base03;
      tab-active = base02;
      notification = base02;
      notification-error = base08;
      equalizer = base0B;
      misc = base02;

      accent = base0B;
      accent-active = base0B;
      accent-inactive = base00;
      banner = base0B;
      border-active = base0D;
      border-inactive = base01;
      header = base03;
    };
  };

  stylix.targets.spicetify.enable = false;
}
