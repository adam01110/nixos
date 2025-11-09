{ ... }:

{
  imports = [
    ./applications
    ./cli
    ./desktop
    ./services
    ./git.nix
    ./gpg.nix
    ./home.nix
    ./ssh.nix
    ./sops.nix
  ];
}
