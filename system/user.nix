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
        "docker"
        "libvirtd"
      ];
    };

    # TODO make this false in future?
    mutableUsers = true;
  };

  nix.settings.allowed-users = [ "${username}" ];
  # dont know to put this in xdg.nix or user.nix
  security.pam.services.${username}.kwallet.enable = true;

  home-manager = {
    # some reasonable home manager settings
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
