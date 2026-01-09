{...}:
# set the default XDG terminal handler.
{
  # register Ghostty as the terminal for terminal-exec.
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = ["com.mitchellh.ghostty.desktop"];
    };
  };
}
