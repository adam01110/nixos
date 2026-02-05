_: _final: prev:
# Expose local zaread package under pkgs.
{
  zaread = prev.callPackage ../pkgs/zaread.nix {};
}
