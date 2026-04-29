{self, ...}: _final: prev: {
  zaread = prev.callPackage "${self}/pkgs/zaread.nix" {};
}
