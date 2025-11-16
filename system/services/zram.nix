{ ... }:

# compressed swap in ram for responsiveness under load.
{
  zramSwap = {
    enable = true;
    priority = 100;
  };
}
