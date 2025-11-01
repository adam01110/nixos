{
  config,
  lib,
  pkgs,
  inputs,
  system,
  vars,
  ...
}:

let
  inherit (vars) username;
in
{
  sops.secrets.user_password.neededForUsers = true;

  users = {
    mutableUsers = false;

    users.${username} = {
      hashedPasswordFile = config.sops.secrets.user_password.path;
      isNormalUser = true;
      ignoreShellProgramCheck = true;
      description = "${username}";
      extraGroups = [
        "wheel"
        "audio"
        "networkmanager"
      ];
    };
  };

  nix.settings.allowed-users = [ "${username}" ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit
        inputs
        system
        vars
        ;
    };

    users.${username} = {
      programs.home-manager.enable = true;
      imports =
        with inputs;
        [
          nix-flatpak.homeManagerModules.nix-flatpak
          sops-nix.homeManagerModules.sops
          noctalia.homeModules.default
          nix-index-database.homeModules.nix-index
          zen-browser.homeModules.beta
          equinix.homeModules.equinix
        ]
        ++ [ ./../home ];
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        stateVersion = config.system.stateVersion;
      };
    };
  };
}
