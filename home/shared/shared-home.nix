{ pkgs, nixpkgs-unstable, ... }: {
  programs = {
    bash = {
			enable = true;
      package = pkgs.bashInteractive;
			initExtra = ''
complete -cf sudo
PS1="\[\e[36;2m\][\[\e[0m\]\[\e[32m\]\u\[\e[33m\]@\[\e[94m\]\h\[\e[35m\] \W\[\e[36;2m\]]\[\e[0m\]$ "
			'';
			shellAliases = {
			  rebuild = "sudo nixos-rebuild switch --flake ~/.config/nixos/";
				rebuild-home = "home-manager switch --flake ~/.config/nixos/";
				edit-config = "nvim ~/.config/nixos/hosts/$(hostname)/configuration.nix";
				edit-home = "nvim ~/.config/nixos/home/$(whoami)/home.nix";
        sd = "cd ~ && cd $(find . -path ./disks -prune -o -path ./.local -prune -o -type d -name \"*\" | fzf)";
			};
		};

		neovim = {
			enable = true;
			defaultEditor = true;
			viAlias = true;
			vimAlias = true;
			package = nixpkgs-unstable.legacyPackages."${pkgs.stdenv.system}".neovim-unwrapped;
		};

    fzf = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
