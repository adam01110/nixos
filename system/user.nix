{
  config,
  pkgs,
  inputs,
  vars,
  ...
}:
# user account and home manager setup.
let
  inherit (vars) username;
in {
  # ensure the user account can be created with a password managed by sops-nix.
  sops.secrets.user_password.neededForUsers = true;

  users = {
    # manage users declaratively, disables imperative changes via passwd/useradd.
    mutableUsers = false;

    users.${username} = {
      # hashed password file provided by sops-nix.
      hashedPasswordFile = config.sops.secrets.user_password.path;

      # group memberships:
      # - wheel: administrative access via sudo.
      # - audio: access to sound devices.
      extraGroups = [
        "wheel"
        "audio"
      ];

      isNormalUser = true;
      # allow non-standard shells without /etc/shells checks.
      ignoreShellProgramCheck = true;
      description = username;
      shell = pkgs.fish;
    };
  };

  # allow the user to perform privileged nix operations.
  nix.settings = {
    allowed-users = [username];
    trusted-users = [username];
  };

  # home manager setup.
  home-manager = {
    # install home manager packages into the user's profile instead of the system profile.
    useUserPackages = true;
    # reuse the system's nixpkgs for consistency and caching.
    useGlobalPkgs = true;
    # suffix used when home manager backs up existing files it will manage.
    backupFileExtension = "bak";

    # pass shared context (flake inputs and vars) to home manager modules.
    extraSpecialArgs = {
      inherit
        inputs
        vars
        ;
    };

    users.${username} = {
      # home manager module sources from flake inputs.
      imports = with inputs; [
        nix-flatpak.homeManagerModules.nix-flatpak
        sops-nix.homeManagerModules.sops
        noctalia.homeModules.default
        nix-index-database.homeModules.nix-index
        zen-browser.homeModules.beta
        nixcord.homeModules.nixcord
        nvf.homeManagerModules.default
        spicetify-nix.homeManagerModules.spicetify
        zed-extensions.homeManagerModules.default
        (import-tree ../home)
      ];

      home = {
        # home-manager account identity.
        inherit username;
        homeDirectory = "/home/${username}";

        # align home manager state version with the system.
        inherit (config.system) stateVersion;
      };
    };
  };
}
