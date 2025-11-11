{
  pkgs,
  ...
}:

{
  # cpu and i/o autotuning via ananicy-cpp with cachyos rules.
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos_git;
  };
}
