{
  inputs,
  lib,
  ...
}: final: _prev:
# Expose ./pkgs as top-level pkgs.* entries.
import ../pkgs {
  inherit
    inputs
    lib
    ;

  pkgs = final;
}
