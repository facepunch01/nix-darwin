{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.

  home.username = "jakehackl";
  home.packages = with pkgs; 
		[ 
			# Editor
			neovim
			# Parsing
			ghostscript 
			# Info
			btop
			neofetch
			# Shell
      fish
      nushell
		  # Doom emacs required or notes
		  asciidoctor
      aspell
      bat
      fd
      gnuplot
      nb
      ranger
      ripgrep
      tree-sitter
			silver-searcher
			kitty
		];
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
	programs.zsh = {
		enabled = true;
		initExtra = "
fish
";
	};
	programs.fish = {
		enable = true;
		initExtra = @"
if status is-interactive
  set fish_greeting
  alias calc=\"emacsclient -c -n -q -e \(full-calc\)\"
  alias icat=\"kitty +kitten icat\"
	alias renix=\"darwin-rebuild switch --flake ~/.config/nix-darwin/\"
	alias upnix=\"cd .config/nix-darwin/;nix flake update;cd ~/\"
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/jakehackl/miniconda3/bin/conda
    eval /Users/jakehackl/miniconda3/bin/conda \"shell.fish\" \"hook\" $argv | source
end
# <<< conda initialize <<<
bass source \"$HOME/.cargo/env\"
set BUN_INSTALL \"$HOME/.bun\"
set PATH \"$BUN_INSTALL/bin:/opt/pkg/bin:$PATH\"
set MANPATH \"/opt/pkg/man:$MANPATH\"
"
		}
  home.sessionVariables.EDITOR = "nvim";
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
