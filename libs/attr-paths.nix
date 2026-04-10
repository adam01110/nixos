{lib}:
# Helpers for dotted attribute-path lookups.
{
  # keep-sorted start block=yes newline_separated=yes
  # Resolve a dotted attribute path against an attribute set.
  attrByPath = root: path: lib.getAttrFromPath (lib.splitString "." path) root;

  # Resolve multiple dotted attribute paths against an attribute set.
  attrsByPath = root: paths: map (path: lib.getAttrFromPath (lib.splitString "." path) root) paths;

  # Resolve package-producing dotted paths and return their `package` attrs.
  packagesByPath = root: paths: map (path: (lib.getAttrFromPath (lib.splitString "." path) root).package) paths;
  # keep-sorted end
}
