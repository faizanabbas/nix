{ user, ... }:

{
  home.username = user;
  home.homeDirectory = "/home/${user}";

  # Fix for WSL GL issues
  targets.genericLinux.enable = true;

  # Fix for non-NixOS linux systems not being able to change login shell
  programs.bash = {
    enable = true;

    # Add this script to the bottom of .bashrc
    initExtra = ''
      # If not running interactively, don't do anything
      [[ $- != *i* ]] && return

      # If we are already in zsh, don't do anything (prevent loops)
      [[ -n "$ZSH_VERSION" ]] && return

      # If zsh is installed, switch to it
      if command -v zsh > /dev/null 2>&1; then
        export SHELL=$(command -v zsh)
        exec zsh
      fi
    '';
  };
}
