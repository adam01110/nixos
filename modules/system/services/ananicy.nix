{pkgs, ...}: {
  # Cpu and i/o autotuning via ananicy-cpp with cachyos rules.
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;

    # Use cachyos rules.
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };
}
