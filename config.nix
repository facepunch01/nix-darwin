{ config, pkgs, ... }:
{
  environment.systemPackages =
    [ 
		# stuff from homebrew
      pkgs.asciidoctor
      pkgs.aspell
      pkgs.bat
      pkgs.coreutils
      pkgs.curl
      pkgs.dash
      pkgs.fd
      pkgs.ffmpeg
      pkgs.fish
      pkgs.gcc
      pkgs.gi-docgen
      pkgs.git
      pkgs.gnuplot
      pkgs.go
      pkgs.hugo
      pkgs.imagemagick
      pkgs.luajit
      pkgs.nb
      pkgs.neofetch
      pkgs.nodejs
      pkgs.nushell
      pkgs.ranger
      pkgs.ripgrep
      pkgs.tealdeer
      pkgs.tig
      pkgs.tree-sitter
			pkgs.silver-searcher
			# EDITORS
			pkgs.neovim
			# TOOLS
			pkgs.texlive.combined.scheme-full
		];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";
  users.users.jakehackl = {
    home = /Users/jakehackl/;
    description = "me";
  };

 	nixpkgs.config.allowBroken = true;
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;
	nixpkgs.hostPlatform = "aarch64-darwin";
  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

}
