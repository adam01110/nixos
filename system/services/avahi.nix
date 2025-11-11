{ ... }:

{
  # mdns/dns-sd discovery for local network.
  services.avahi = {
    enable = true;

    nssmdns4 = true;
    nssmdns6 = true;
  };
}
