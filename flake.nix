{

	description = "im too far gone";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

		home-manager = {
			url = "github:nix-community/home-manager/release-24.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, home-manager, ... }:
		let
			system = "x86_64-linux";
		in {
			nixosConfigurations = {
				MagnumOpus = nixpkgs.lib.nixosSystem {
					inherit system;
					modules = [
						./hosts/MagnumOpus/configuration.nix
					];
				};

				Bunker = nixpkgs.lib.nixosSystem {
					inherit system;
					modules = [
						./hosts/Bunker/configuration.nix
					];
				};
			};

			homeConfigurations = {
				aiffelowy = home-manager.lib.homeManagerConfiguration {
					pkgs = nixpkgs.legacyPackages.${system};
					modules = [ ./home/aiffelowy/home.nix ];
				};
			};
		};

}
