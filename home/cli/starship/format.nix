{
  lib,
  ...
}:

let
  inherit (lib) concatStrings;
in
{
  format = concatStrings [
    "[](fg:base01)"
    "$hostname"
    "[/](fg:base05 bg:base01)"
    "$username"
    "[](fg:base01)"

    "[ ](#00000000)"
    "[](fg:base01)"
    "$os"
    "[ ](bg:base01)"
    "$shell"
    "[](fg:base01)"

    "$nix_shell"

    "$container"
    "$docker_context"

    "$directory"
    "$sudo"
    "$jobs"

    "$fossil_branch"
    "[ ](#00000000)"
    "[](fg:base01)"
    "$git_branch"
    "[ ](bg:base01)"
    "$git_commit"
    "$git_state"
    "$git_status"
    "[](fg:base01)"

    "$package"

    "$bun"
    "$deno"
    "$nodejs"

    "$cmake"
    "$gradle"
    "$meson"

    "$c"
    "$cpp"
    "$dart"
    "$dotnet"
    "$golang"
    "$haskell"
    "$haxe"
    "$java"
    "$kotlin"
    "$lua"
    "$perl"
    "$php"
    "$python"
    "$ruby"
    "$rust"
    "$swift"
    "$zig"

    "$line_break"
    "$character"
  ];
}
