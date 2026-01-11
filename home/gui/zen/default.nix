{...}: {
  imports = [
    ./chrome.nix
    ./extensions.nix
    ./policies.nix
    ./preferences.nix
    ./search.nix
    ./spaces.nix
  ];

  # enable zen browser.
  programs.zen-browser.enable = true;
}
