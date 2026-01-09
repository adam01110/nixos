{
  config,
  pkgs,
  ...
}:
# gnupg and gpg-agent with ssh support and gnome pinentry.
{
  programs.gpg = {
    enable = true;

    # store the keyring under xdg data home instead of ~/.gnupg
    homedir = "${config.xdg.dataHome}/gnupg";
  };

  services.gpg-agent = {
    enable = true;

    # expose an ssh agent socket from gpg-agent so ssh can use
    # keys stored on smartcards or in the gpg keyring.
    enableSshSupport = true;

    # use the gnome pinentry for passphrase prompts.
    pinentry.package = pkgs.pinentry-gnome3;
  };

  # package needed for pintenty gnome
  home.packages = [pkgs.gcr];
}
