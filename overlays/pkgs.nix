{
  inputs,
  lib,
  ...
}: final: _prev:
# expose ./pkgs as top-level pkgs.* entries.
import ../pkgs {
  inherit
    inputs
    lib
    ;

  pkgs = final;
}
