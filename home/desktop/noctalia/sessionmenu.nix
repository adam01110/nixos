{ ... }:

# session menu entries and confirmation timing.
{
  programs.noctalia-shell.settings.sessionMenu = {
    countdownDuration = 8000;
    powerOptions = [
      {
        action = "lock";
        enabled = true;
        countdownEnabled = false;
      }
      {
        action = "suspend";
        enabled = true;
        countdownEnabled = true;
      }
      {
        action = "reboot";
        enabled = true;
        countdownEnabled = true;
      }
      {
        action = "logout";
        enabled = true;
        countdownEnabled = true;
      }
      {
        action = "shutdown";
        enabled = true;
        countdownEnabled = true;
      }
      {
        action = "hibernate";
        enabled = false;
        countdownEnabled = true;
      }
    ];
  };
}
