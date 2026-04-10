_: {
  services.gnome = {
    # keep-sorted start newline_separated=yes
    # Disable the gcr ssh agent managed by GNOME.
    gcr-ssh-agent.enable = false;

    # Start keyring services for secret storage.
    gnome-keyring.enable = true;
    # keep-sorted end
  };

  # Hook keyring into login and greetd sessions.
  security.pam.services = {
    login.enableGnomeKeyring = true;
    greetd.enableGnomeKeyring = true;
  };
}
