_:
# zram compressed swap for improved system responsiveness under memory pressure.
{
  zramSwap = {
    enable = true;
    priority = 100;
  };
}
