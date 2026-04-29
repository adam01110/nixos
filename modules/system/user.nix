{
  # keep-sorted start
  config,
  flakeLib,
  inputs,
  pkgs,
  self,
  vars,
  # keep-sorted end
  ...
}: let
  inherit (flakeLib) attrsByPath importTree;
  inherit
    (vars)
    # keep-sorted start
    fullName
    username
    # keep-sorted end
    ;
in {
  # Ensure the user account can be created with a password managed by sops-nix.
  sops.secrets.user_password.neededForUsers = true;

  # keep-sorted start block=yes newline_separated=yes
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
        flakeLib
        inputs
        self
        vars
        # keep-sorted end
        ;
    };

    users.${username} = {
      # Home manager module sources from flake inputs.
      imports =
        attrsByPath inputs [
          # keep-sorted start
          "nix-flatpak.homeManagerModules.nix-flatpak"
          "nix-index-database.homeModules.nix-index"
          "nixcord.homeModules.nixcord"
          "noctalia.homeModules.default"
          "nvf.homeManagerModules.default"
          "overzicht.homeModules.default"
          "sops-nix.homeManagerModules.sops"
          "spicetify-nix.homeManagerModules.spicetify"
          "zen-browser.homeModules.beta"
          # keep-sorted end
        ]
        ++ [
          pkgs.nur.repos.adam0.hmModules.opencode-plugins
          (importTree "${self}/modules/home")
        ];

      home = {
        inherit username;
        homeDirectory = "/home/${username}";

        # Align home manager state version with the system.
        inherit (config.system) stateVersion;
      };
    };
  };

  # Allow the user to perform privileged nix operations.
  nix.settings = {
    # keep-sorted start
    allowed-users = [username];
    trusted-users = [username];
    # keep-sorted end
  };

  users = {
    # Manage users declaratively, disables imperative changes via passwd/useradd.
    mutableUsers = false;

    users.${username} = {
      # Hashed password file provided by sops-nix.
      hashedPasswordFile = config.sops.secrets.user_password.path;

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
  # keep-sorted end
}
