{
  config,
  lib,
  pkgs,
  inputs,
  system,
  username,
  ...
}:

let
  systemStateVersion = config.system.stateVersion;
in
{
  users = {
    users.${username} = {
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
          nix-flatpak.nixosModules.nix-flatpak
          zen-browser.homeModules.beta
          inputs.noctalia.homeModules.default
        ]
        ++ [ ./../home ];
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        stateVersion = systemStateVersion;
      };
    };
  };
}
