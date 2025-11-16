{ ... }:

{
  # disable the gnome keyring ssh agent integration.
  nixpkgs.overlays = [
    (final: prev: {
      gnome = prev.gnome.overrideScope (
        gfinal: gprev: {
          gnome-keyring = gprev.gnome-keyring.overrideAttrs (oldAttrs: {
            configureFlags = (oldAttrs.configureFlags or [ ]) ++ [ "--disable-ssh-agent" ];
          });
        }
      );
    })
  ];

  # start keyring services for secret storage.
  services.gnome.gnome-keyring.enable = true;

  # hook keyring into login and greetd sessions.
  security.pam.services = {
    login.enableGnomeKeyring = true;
    greetd.enableGnomeKeyring = true;
  };
}
