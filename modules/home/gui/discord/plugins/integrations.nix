_:
# Integrations with external services and providers.
{
  programs.nixcord.config.plugins = {
    # keep-sorted start block=yes
    Dragify.enable = true;
    GitHubRepos.enable = true;
    OpenInApp = {
      enable = true;
      # keep-sorted start
      itunes = false;
      spotify = false;
      tidal = false;
      # keep-sorted end
    };
    ReplaceGoogleSearch = {
      enable = true;
      replacementEngine = "Brave";
    };
    ReverseImageSearch.enable = true;
    UnitConverter = {
      enable = true;
      myUnits = "metric";
    };
    # keep-sorted end
  };
}
