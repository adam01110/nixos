_: {
  # keep-sorted start block=yes newline_separated=yes
  # Hook keyring into login and greetd sessions.
  security.pam.services = {
    login.enableGnomeKeyring = true;
    greetd.enableGnomeKeyring = true;
  };

  services.gnome = {
    # keep-sorted start newline_separated=yes
    # Disable the gcr ssh agent managed by GNOME.
    gcr-ssh-agent.enable = false;

    # Start keyring services for secret storage.
    gnome-keyring.enable = true;
    # keep-sorted end
  };
  # keep-sorted end
}
