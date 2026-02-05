_: {
  # Mdns/dns-sd discovery for local network.
  services.avahi = {
    enable = true;

    # Hook avahi into glibc resolver for mdns.
    nssmdns4 = true;
    nssmdns6 = true;
  };
}
