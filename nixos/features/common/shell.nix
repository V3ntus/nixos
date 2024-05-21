{pkgs, ...}: {
  environment.variables = {
    ZSH_COLORIZE_TOOL = "chroma";
  };

  programs = {
    zsh = {
      enable = true;
      promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      enableCompletion = true;
      syntaxHighlighting.enable = true;

      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "colored-man-pages"
          "z"
        ];
      };

      shellAliases = {
        ls = "${pkgs.eza} -a --long --header --git --icons=always";
        nix-gc = "nix-store --gc --print-roots | awk '{print $1}' | grep /result$ | sudo xargs rm";
      };
    };
  };

  services.atuin.enable = true;

  programs.nano.nanorc = ''
    set tabstospaces
    set tabsize 2
  '';
}
