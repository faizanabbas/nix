{ pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in
{
  home.stateVersion = "25.11";

  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  home.packages =
    with pkgs;
    [
      awscli2
      eza
      fd
      fzf
      gh
      git
      gnupg
      nerd-fonts.jetbrains-mono
      jq
      nil
      nixd
      ripgrep
      tree
    ]
    ++ (lib.optionals isDarwin [
      pinentry_mac
    ])
    ++ (lib.optionals isLinux [
      pinentry-curses
    ]);

  fonts.fontconfig.enable = true;

  #---------------------------------------------------------------------
  # Environment variables & dotfiles
  #---------------------------------------------------------------------

  home.sessionVariables = {
    EDITOR = "vim";
    GOPATH = "~/.local/share/go";
  };

  #---------------------------------------------------------------------
  # Programs & services
  #---------------------------------------------------------------------

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    signing = {
      key = "225949B2D581DEA5";
      signByDefault = true;
    };
    settings = {
      user = {
        name = "Faizan Abbas";
        email = "faizan@faizanabbas.com";
        useConfigOnly = true;
      };
      init.defaultBranch = "main";
      gpg.program = "${pkgs.gnupg}/bin/gpg";
    };

    includes = [
      {
        condition =
          if isDarwin then
            "gitdir:~/Developer/Repositories/github.com/harkerapp/"
          else
            "gitdir:~/Repositories/github.com/harkerapp/";
        contents = {
          user = {
            email = "faizan@harkerapp.com";
          };
          signing = {
            key = "CE58DE2247AADB29";
            signByDefault = true;
          };
        };
      }
    ];
  };

  programs.gpg = {
    enable = true;
  };

  programs.mise = {
    enable = true;

    globalConfig = {
      tools = {
        bun = "latest";
        deno = "latest";
        go = "latest";
        node = "24";
        python = "latest";
      };
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "eza --grid --icons --sort=type";
      rebuild =
        if isDarwin then
          "sudo darwin-rebuild switch --flake ~/.config/nix/#mac"
        else
          "home-manager switch --flake ~/.config/nix/#wsl";
    };
  };

  programs.oh-my-posh = {
    enable = true;
    useTheme = "gruvbox";
  };

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    pinentry.package = if isDarwin then pkgs.pinentry_mac else pkgs.pinentry_curses;
  };
}
