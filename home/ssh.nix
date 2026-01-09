{
  config,
  vars,
  ...
}:
# ssh client config with sops-injected host templates.
let
  inherit (vars) username;
in {
  sops = {
    secrets = {
      # hostname for the euclid server host, stored in sops.
      "servers/euclid/hostname" = {};

      # write the ssh public and private keys.
      "servers/euclid/private_ssh_key".path = "/home/${username}/.ssh/euclid";
      "servers/euclid/public_ssh_key".path = "/home/${username}/.ssh/euclid.pub";
    };

    # template that expands to a host block included below.
    templates."ssh-config-server".content = ''
      Host server
        HostName ${config.sops.placeholder."servers/euclid/hostname"}
        IdentityFile ~/.ssh/server
    '';
  };

  programs.ssh = {
    enable = true;

    # got a warning asking me to disable this, dont touch for now?
    enableDefaultConfig = false;

    # dedicate a key for github traffic to keep identities separate.
    matchBlocks."github.com" = {
      hostname = "github.com";
      identityFile = "~/.ssh/git";
    };

    # pull in the sops-generated server host.
    includes = [config.sops.templates."ssh-config-server".path];
  };
}
