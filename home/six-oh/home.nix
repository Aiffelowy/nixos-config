{config, pkgs, ...}: {
	imports = [ ../shared/shared-home.nix ];
	home = {
		username = "six-oh";
		homeDirectory = "/home/six-oh";
		stateVersion = "24.05";
		
		packages = with pkgs; [
			tmux
		];
	};
	
	programs.home-manager.enable = true;
}
