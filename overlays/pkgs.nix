{
  # keep-sorted start
  inputs,
  lib,
  self,
  # keep-sorted end
  ...
}: final: _prev:
import "${self}/pkgs" {
  inherit
    # keep-sorted start
    inputs
    lib
    self
    # keep-sorted end
    ;

  pkgs = final;
}
