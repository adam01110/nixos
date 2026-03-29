{lib, ...}:
# Expose each repo-managed .md skill as .agents/skills/<name>/SKILL.md.
let
  inherit (builtins) readDir;
  inherit
    (lib)
    filterAttrs
    hasSuffix
    mapAttrs'
    nameValuePair
    removeSuffix
    ;
in {
  home.file =
    mapAttrs' (
      name: _:
        nameValuePair ".agents/skills/${removeSuffix ".md" name}/SKILL.md" {
          source = ./. + "/${name}";
        }
    ) (
      filterAttrs (
        name: type: type == "regular" && hasSuffix ".md" name
      ) (readDir ./.)
    );
}
