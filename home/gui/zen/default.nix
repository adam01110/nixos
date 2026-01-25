{...}: {
  imports = [
    ./chrome.nix
    ./extensions.nix
    ./mods.nix
    ./policies.nix
    ./preferences.nix
    ./search.nix
    ./spaces.nix
  ];

  # enable zen browser.
  programs.zen-browser.enable = true;
}
