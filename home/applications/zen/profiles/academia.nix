{
  commonExtensions,
  commonSearchEngines,
  ...
}:

# academia zen profile inheriting common settings.
{
  academia = {
    id = 1;
    isDefault = false;

    # add the extenions shared by every profile.
    extensions = {
      force = true;
      packages = commonExtensions;
    };

    # add the search engines shared by every profile.
    search = {
      force = true;
      default = "brave";
      engines = commonSearchEngines;
    };

    # set zen spaces.
    spacesForce = true;
    spaces = {
      "general" = {
        id = "ea8b317f-fd64-436d-8165-e9b0107e80fc";
        position = 1000;
        icon = "🧶";
      };
      "hidden" = {
        id = "61d9efa7-7e10-4cdb-b8b7-6dc023c4557f";
        position = 2000;
        icon = "🧵";
      };
    };
  };
}
