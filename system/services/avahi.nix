{ ... }:

{
  # mdns/dns-sd discovery for local network.
  services.avahi = {
    enable = true;

    # hook avahi into glibc resolver for mdns.
    nssmdns4 = true;
    nssmdns6 = true;
  };
}
