{ ... }:

# integrations with external services and providers.
{
  gitHubRepos.enabled = true;
  openInApp = {
    enabled = true;
    spotify = false;
    tidal = false;
    itunes = false;
  };
  replaceGoogleSearch = {
    enabled = true;
    replacementEngine = "Brave";
  };
  reverseImageSearch.enabled = true;
  unitConverter = {
    enabled = true;
    myUnits = "metric";
  };
}
