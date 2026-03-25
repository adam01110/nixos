_:
# Set the default XDG terminal handler.
{
  # Register Ghostty as the terminal for terminal-exec.
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = ["com.mitchellh.ghostty.desktop"];
    };
  };
}
