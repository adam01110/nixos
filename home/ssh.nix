{
  config,
  ...
}:

# ssh client config with sops-injected host templates.
{
  sops = {
    # hostname for the `server` host alias, stored in sops.
    secrets.server_hostname = { };

    # template that expands to a host block included below.
    # TODO
    templates."ssh-config-server".content = ''
      Host server
        HostName ${config.sops.placeholder.server_hostname}
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
      identityFile = "~/.ssh/github";
    };

    # pull in the sops-generated server host.
    includes = [ config.sops.templates."ssh-config-server".path ];
  };
}
