_:
# Zen browser workspace/spaces configuration.
{
  programs.zen-browser.profiles.default = {
    # Force spaces to be enabled.
    spacesForce = true;
    spaces = {
      # keep-sorted start block=yes newline_separated=yes
      # Development space for coding and technical resources.
      "dev" = {
        id = "9b41acc7-1eb2-4c14-9fba-7f6d670db845";
        position = 2000;
        icon = "🖥️";
      };

      # Gaming space for entertainment and gaming content.
      "gaming" = {
        id = "70e211cd-676f-4abb-9317-35fac2078913";
        position = 3000;
        icon = "🎮";
      };

      # General browsing space with productivity focus.
      "general" = {
        id = "29680918-95d2-4162-ba72-1c41bd1b628d";
        position = 1000;
        icon = "🧶";
      };

      # News space for current events and information.
      "news" = {
        id = "b2e284cd-b0d6-4d05-9b0a-9021148ff0bb";
        position = 4000;
        icon = "🗞️";
      };
      # keep-sorted end
    };
  };
}
