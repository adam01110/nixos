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
      hashedPasswordFile =
        let
          UserPassword = config.sops.secrets.user-password.path;
        in
        UserPassword;
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
          nix-flatpak.homeManagerModules.nix-flatpak
          zen-browser.homeModules.beta
          noctalia.homeModules.default
          sops-nix.homeManagerModules.sops
        ]
        ++ [ ./../home ];
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        stateVersion =
          let
            systemStateVersion = config.system.stateVersion;
          in
          systemStateVersion;
      };
    };
  };
}
