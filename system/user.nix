{
  config,
  lib,
  pkgs,
  inputs,
  system,
  username,
  ...
}:

{
  sops.secrets.user-password.neededForUsers = true;

  users = {
    mutableUsers = false;

    users.${username} = {
      hashedPasswordFile = config.sops.secrets.user-password.path;
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
        username
        ;
    };

    users.${username} = {
      programs.home-manager.enable = true;
      imports =
        with inputs;
        [
          equinix.homeModules.equinix
          nix-flatpak.homeManagerModules.nix-flatpak
          noctalia.homeModules.default
          sops-nix.homeManagerModules.sops
          zen-browser.homeModules.beta
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
