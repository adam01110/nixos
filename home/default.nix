{ ... }:

{
  imports = [
    ./applications
    ./cli
    ./desktop
    ./services
    ./tui
    ./git.nix
    ./gpg.nix
    ./home.nix
    ./ssh.nix
    ./sops.nix
  ];
}
