{
  config,
  lib,
  pkgs,
  inputs,
  vars,
  ...
}:
# User account and home manager setup.
let
  inherit
    (lib)
    getAttrFromPath
    splitString
    ;
  inherit
    (vars)
    username
    fullName
    ;

  import-tree = inputs.import-tree.withLib lib;
in {
  # Ensure the user account can be created with a password managed by sops-nix.
  sops.secrets.user_password.neededForUsers = true;

  users = {
    # Manage users declaratively, disables imperative changes via passwd/useradd.
    mutableUsers = false;

    users.${username} = {
      # Hashed password file provided by sops-nix.
      hashedPasswordFile = config.sops.secrets.user_password.path;

      # Group memberships:
      # - `wheel`: administrative access via sudo.
      # - `audio`: access to sound devices.
      extraGroups = [
        "wheel"
        "audio"
      ];

      isNormalUser = true;
      # Allow non-standard shells without /etc/shells checks.
      ignoreShellProgramCheck = true;
      description = fullName;
      shell = pkgs.fish;
    };
  };

  # Allow the user to perform privileged nix operations.
  nix.settings = {
    allowed-users = [username];
    trusted-users = [username];
  };

  # Home manager setup.
  home-manager = {
    # Install home manager packages into the user's profile instead of the system profile.
    useUserPackages = true;
    # Reuse the system's nixpkgs for consistency and caching.
    useGlobalPkgs = true;
    # Suffix used when home manager backs up existing files it will manage.
    backupFileExtension = "bak";

    # Pass shared context (flake inputs and vars) to home manager modules.
    extraSpecialArgs = {
      inherit
        inputs
        vars
        ;
    };

    users.${username} = {
      # Home manager module sources from flake inputs.
      imports =
        (map (path: getAttrFromPath (splitString "." path) inputs) [
          "nix-flatpak.homeManagerModules.nix-flatpak"
          "sops-nix.homeManagerModules.sops"
          "noctalia.homeModules.default"
          "overzicht.homeModules.default"
          "nix-index-database.homeModules.nix-index"
          "zen-browser.homeModules.beta"
          "nixcord.homeModules.nixcord"
          "nvf.homeManagerModules.default"
          "spicetify-nix.homeManagerModules.spicetify"
          "zed-extensions.homeManagerModules.default"
        ])
        ++ [
          pkgs.nur.repos.adam0.hmModules.opencode-plugins
          (import-tree ../home)
        ];

      home = {
        # Home-manager account identity.
        inherit username;
        homeDirectory = "/home/${username}";

        # Align home manager state version with the system.
        inherit (config.system) stateVersion;
      };
    };
  };
}
