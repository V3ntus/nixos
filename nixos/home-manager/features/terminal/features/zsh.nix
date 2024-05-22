{
  pkgs,
  config,
  ...
}: {
  environment.variables = {
    ZSH_COLORIZE_TOOL = "chroma";
  };

  programs.thefuck.enable = true;

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      dotDir = ".config/zsh";

      history = {
        size = 100000;
        save = 100000;
        share = true;
        extended = true;
        ignoreAllDups = true;
        ignoreSpace = true;
        path = "${config.xdg.dataHome}/zsh/zsh_history";
      };

      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "colored-man-pages"
          "z"
          "fzf"
          "grc"
          "thefuck"
        ];
      };

      plugins = [
        {
          name = "zsh-fast-syntax-highlighting";
          src = pkgs.zsh-fast-syntax-highlighting;
          file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
        }
      ];

      shellAliases = {
        ls = "${pkgs.eza}/bin/eza -a --long --header --git --icons=always --color=always";
        nix-gc = "nix-store --gc --print-roots | awk '{print $1}' | grep /result$ | sudo xargs rm";
        cat = "${pkgs.bat}/bin/bat --style=plain";
        ip = "ip -color=auto";
        grep = "grep --color=auto";
        mtr = "trippy";
        tracert = "trippy";
      };

      profileExtra = ''
        setopt no_beep
        setopt rm_star_wait
        setopt hist_ignore_all_dups
        setopt hist_ignore_space
        setopt append_history
        setopt inc_append_history

        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
        zstyle ':completion:*' rehash true

        mkdir -p "$(dirname ~/.cache/zsh/completion-cache)"
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "~/.cache/zsh/completion-cache"
        zstyle ':completion:*' accept-exact '*(N)'
        zstyle ':completion:*' menu select
      '';

      sessionVariables = {
        GREP_COLORS = "ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36";
      };
    };
  };

  services.atuin.enable = true;

  programs.nano.nanorc = ''
    set tabstospaces
    set tabsize 2
  '';
}
