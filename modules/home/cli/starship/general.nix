_:
# Core prompt symbols and common modules.
{
  programs.starship.settings = {
    character = {
      format = "$symbol ";
      success_symbol = "[➜](fg:green bold)";
      error_symbol = "[➜](fg:red bold)";
      vimcmd_symbol = "[](fg:green bold)";
      vimcmd_replace_one_symbol = "[](fg:magenta bold)";
      vimcmd_replace_symbol = "[](fg:magenta bold)";
      vimcmd_visual_symbol = "[](fg:yellow bold)";
    };

    cmd_duration = {
      format = "[ ](#00000000)[ ](bg:base01)[$duration]($style)[ ](bg:base01)";
      style = "bg:base01 fg:yellow bold";
      min_time = 500;
    };

    directory = {
      format = "[ ](#00000000)[ ](bg:base01)[$path]($style)[$read_only]($read_only_style)[ ](bg:base01)";
      style = "bg:base01 fg:blue bold";
      read_only = " ";
      read_only_style = "bg:base01 fg:red bold";
      truncation_length = 2;
      truncation_symbol = "…/";
      truncate_to_repo = true;
    };

    direnv = {
      disabled = false;
      format = "[ ](#00000000)[ ](bg:base01)[$symbol$loaded( \\($allowed\\))]($style)[ ](bg:base01)";
      symbol = " ";
      style = "bg:base01 fg:base09";
    };

    hostname = {
      format = "[$ssh_symbol$hostname]($style)";
      style = "bg:base01 fg:green bold";
      ssh_symbol = "󰖟 ";
      ssh_only = false;
    };

    jobs = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol$number]($style)[ ](bg:base01)";
      symbol = "󱜯 ";
      style = "bg:base01 fg:blue bold";
    };

    nix_shell = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol$state( \\($name\\))]($style)[ ](bg:base01)";
      symbol = "󱄅 ";
      style = "bg:base01 fg:blue bold";
      heuristic = true;
    };

    os = {
      disabled = false;
      format = "[$symbol]($style)";
      style = "bg:base01 fg:base04 bold";

      symbols = let
        linux = "";
        apple = "";
        redhat = "󱄛";
      in {
        Linux = linux;
        NixOS = "󱄅";
        Windows = "";
        Android = "";
        Unknown = "";

        AlmaLinux = "";
        Alpine = "";
        Arch = "";
        Artix = "";
        CachyOS = linux;
        CentOS = "";
        Debian = "";
        Elementary = "";
        EndeavourOS = "";
        Fedora = "";
        Garuda = "";
        Gentoo = "";
        Kali = "";
        Manjaro = "";
        Mint = "󰣭";
        Nobara = "";
        openSUSE = "";
        PikaOS = linux;
        Pop = "";
        Raspbian = "";
        Redhat = redhat;
        RedHatEnterprise = redhat;
        RockyLinux = "";
        Solus = "";
        SUSE = "";
        Ubuntu = "";
        Void = "";
        Zorin = "";

        Macos = apple;
        Ios = apple;

        FreeBSD = "";
        OpenBSD = "";
      };
    };

    package = {
      format = "[ ](#00000000)[ ](bg:base01)[$symbol$version]($style)[ ](bg:base01)";
      symbol = "󰏗 ";
      style = "bg:base01 fg:base09 bold";
      display_private = true;
    };

    shell = {
      disabled = false;
      format = "[$indicator]($style)";
      bash_indicator = "";
      fish_indicator = "";
      zsh_indicator = "";
      powershell_indicator = "󰨊";
      cmd_indicator = "";
      nu_indicator = "󰟆 ";
      unknown_indicator = "";
      style = "bg:base01 fg:base04 bold";
    };

    sudo = {
      disabled = false;
      format = "[ ](#00000000)[ ](bg:base01)[$symbol]($style)[ ](bg:base01)";
      symbol = "";
      style = "bg:base01 fg:yellow bold";
    };

    username = {
      format = "[$user]($style)";
      style_root = "bg:base01 fg:base08 bold";
      style_user = "bg:base01 fg:blue bold";
      show_always = true;
    };
  };
}
