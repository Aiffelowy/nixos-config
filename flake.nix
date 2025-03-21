{

	description = "im too far gone";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/release-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
		let
			system = "x86_64-linux";
			unstable-overlay = {
				nixpkgs.overlays = [
					(final: prev: {
      						unstable = import nixpkgs-unstable {
      						inherit system;
      						config.allowUnfree = true;
      						};
    					})
  				];
			};
		in {
			nixosConfigurations = {
				MagnumOpus = nixpkgs.lib.nixosSystem {
					inherit system;
					modules = [
						unstable-overlay
						./hosts/MagnumOpus/configuration.nix
					];
				};

				Bunker = nixpkgs.lib.nixosSystem {
					inherit system;
					modules = [
						./hosts/Bunker/configuration.nix
					];
				};

				Horizon = nixpkgs.lib.nixosSystem {
					inherit system;
					modules = [
						unstable-overlay
						./hosts/Horizon/configuration.nix
					];
				};

				Calamity = nixpkgs.lib.nixosSystem {
					inherit system;
					modules = [
						unstable-overlay
						./hosts/Calamity/configuration.nix
					];
				};
			};

			homeConfigurations = {
				aiffelowy = home-manager.lib.homeManagerConfiguration {
					pkgs = nixpkgs.legacyPackages.${system};
					modules = [ 
            					unstable-overlay
						./home/shared/shared-home.nix
						./home/aiffelowy/home.nix
					];
					extraSpecialArgs = { inherit nixpkgs-unstable; };
				};

				six-oh = home-manager.lib.homeManagerConfiguration {
					pkgs = nixpkgs.legacyPackages.${system};
					modules = [
						./home/shared/shared-home.nix
						./home/six-oh/home.nix
					];
					extraSpecialArgs = { inherit nixpkgs-unstable; };
				};

				rico = home-manager.lib.homeManagerConfiguration {
					pkgs = nixpkgs.legacyPackages.${system};
					modules = [
						./home/shared/shared-home.nix
						./home/rico/home.nix
				  	];
				  	extraSpecialArgs = { inherit nixpkgs-unstable; };
				};

				mina = home-manager.lib.homeManagerConfiguration {
					pkgs = nixpkgs.legacyPackages.${system};
					modules = [
						./home/shared/shared-home.nix
						./home/mina/home.nix
				  	];
				  	extraSpecialArgs = { inherit nixpkgs-unstable; };
				};
			};
		};

}
