{
  programs = {
    bash = {
			enable = true;
			initExtra = ''
			complete -cf sudo
			PS1="$(tput setaf 66)[$(tput setaf 2)\u$(tput setaf 3)@$(tput setaf 12)\h $(tput setaf 5)\W$(tput setaf 66)]$(tput bold)$ $(tput sgr0)"
			'';
			shellAliases = {
			  rebuild = "sudo nixos-rebuild switch --flake ~/.config/nixos/";
				rebuild-home = "home-manager switch --flake ~/.config/nixos/";
				edit-config = "~/.config/nixos/hosts/$(hostname)/configuration.nix";
				edit-home = "nvim ~/.config/nixos/home/$(whoami)/home.nix";
			};
		};

		neovim = {
			enable = true;
			defaultEditor = true;
		};
  };
}
