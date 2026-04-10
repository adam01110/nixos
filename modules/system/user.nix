{
  # keep-sorted start
  config,
  inputs,
  lib,
  pkgs,
  vars,
  # keep-sorted end
  ...
}:
# User account and home manager setup.
let
  inherit
    (lib)
    # keep-sorted start
    getAttrFromPath
    splitString
    # keep-sorted end
    ;
  inherit
    (vars)
    # keep-sorted start
    fullName
    username
    # keep-sorted end
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
      extraGroups = [
        # keep-sorted start
        "audio"
        "wheel"
        # keep-sorted end
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
        # keep-sorted start
        inputs
        vars
        # keep-sorted end
        ;
    };

    users.${username} = {
      # Home manager module sources from flake inputs.
      imports =
        (map (path: getAttrFromPath (splitString "." path) inputs) [
          # keep-sorted start
          "nix-flatpak.homeManagerModules.nix-flatpak"
          "nix-index-database.homeModules.nix-index"
          "nixcord.homeModules.nixcord"
          "noctalia.homeModules.default"
          "nvf.homeManagerModules.default"
          "overzicht.homeModules.default"
          "sops-nix.homeManagerModules.sops"
          "spicetify-nix.homeManagerModules.spicetify"
          "zed-extensions.homeManagerModules.default"
          "zen-browser.homeModules.beta"
          # keep-sorted end
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
