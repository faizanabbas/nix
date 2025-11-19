{ user, ... }:

{
  home.username = user;
  home.homeDirectory = "/home/${user}";

  # Fix for WSL GL issues
  targets.genericLinux.enable = true;
}
