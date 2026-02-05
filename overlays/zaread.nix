_: _final: prev:
# expose local zaread package under pkgs.
{
  zaread = prev.callPackage ../pkgs/zaread.nix {};
}
