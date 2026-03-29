rec {
  # Identity shared across modules.
  username = "adam0";
  fullName = "Adam0";

  # Git and identity.
  gitUsername = "${username}1110";
  gitPublicSshkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDk3Fc80bWSFt41iDx1pzhFHP8EzDwJwPiyrhVV01i+9 Authentication key alumail@protonmail.com";
  gitSigningKey = "0FFE5DE6328D5EC9";

  # Regional defaults for locale-sensitive modules.
  countryCode = "NL";
  defaultLocale = "en_US.UTF-8";
  regionalLocale = "nl_${countryCode}.UTF-8";
  noctaliaFirstDayOfWeek = 1;
}
