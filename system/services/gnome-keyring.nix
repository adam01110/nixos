_: {
  services.gnome = {
    # Start keyring services for secret storage.
    gnome-keyring.enable = true;

    # Disable the gcr ssh agent managed by GNOME.
    gcr-ssh-agent.enable = false;
  };

  # Hook keyring into login and greetd sessions.
  security.pam.services = {
    login.enableGnomeKeyring = true;
    greetd.enableGnomeKeyring = true;
  };
}
