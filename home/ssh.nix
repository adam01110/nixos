{
  config,
  lib,
  pkgs,
  ...
}:

let
  serverHostname = config.sops.secrets.server_hostname;
in
{
  sops.secrets.server_hostname = { };

  programs.ssh = {
    enable = true;

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/github";
        preferredAuthentications = "publickey";
      };
      server = {
        hostname = "${serverHostname}";
        identityFile = "~/.ssh/server";
      };
    };
  };
}
