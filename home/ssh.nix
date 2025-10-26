{
  config,
  lib,
  pkgs,
  ...
}:

{
  sops = {
    secrets.server_hostname = { };

    templates."ssh-config-server".content = ''
      Host server
        HostName ${config.sops.placeholder.server_hostname}
        IdentityFile ~/.ssh/server
    '';
  };

  programs.ssh = {
    enable = true;

    enableDefaultConfig = false;

    matchBlocks."github.com" = {
      hostname = "github.com";
      identityFile = "~/.ssh/github";
    };

    includes = [ config.sops.templates."ssh-config-server".path ];
  };
}
