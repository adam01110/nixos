{ ... }:

{
  services.gnome = {
    # start keyring services for secret storage.
    gnome-keyring.enable = true;

    # disable the gcr ssh agent managed by GNOME.
    gcr-ssh-agent.enable = true;
  };

  # hook keyring into login and greetd sessions.
  security.pam.services = {
    login.enableGnomeKeyring = true;
    greetd.enableGnomeKeyring = true;
  };
}
