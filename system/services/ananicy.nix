{pkgs, ...}: {
  # cpu and i/o autotuning via ananicy-cpp with cachyos rules.
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    # prefer cachyos ruleset for desktop responsiveness.
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };
}
