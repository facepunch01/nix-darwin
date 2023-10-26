{
  description = "Darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, darwin, nixpkgs, home-manager, ... }:
  let
    configuration = { pkgs, config, vars, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
			environment = {
				systemPackages = with pkgs; [
				  # Base compilers and languages and tools
					gcc
					go
					luajit
      		nodejs
      		coreutils
      		curl
      		dash
      		git
      		hugo
      		imagemagick
					# VIDEO
      		ffmpeg
					# INFO TOOLS
					texlive.combined.scheme-full
					btop
      		tealdeer
      		tig
      		neofetch
        ];
			};
      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;
			
  		users.users.jakehackl = {
    		name = "jakehackl";
   		  home = "/Users/jakehackl";
  		};
 			nixpkgs.config.allowBroken = true;
      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;
			homebrew = {
				enable = true;
				brews = [
					{ 
						name = "emacs-plus@29";
						args = [ "with-imagemagick" "with-native-comp" "with-poll" "with-xwidgets" ];
						restart_service = true;
					}
					{
						name = "koekeishiya/formulae/yabai";
					}
				];
				casks = [
					"handbrake"
					"gzdoom"
					"inkscape"
					"vieb"
					"qutebrowser"
					"font-jetbrains-mono-nerd-font"
					"font-iosevka-aile"
				];
			};

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
	in
	{
	
    darwinConfigurations."Jakes-MacBook-Pro" = darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jakehackl = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
		darwinPackages = self.darwinConfigurations."Jakes-MacBook-Pro".pkgs;
  };
}
