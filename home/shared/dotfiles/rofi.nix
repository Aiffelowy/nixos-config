{config, ...}: let
  inherit (config.lib.formats.rasi) mkLiteral;
	darker_background = "#0B0F10";
  background_primary = "#101415";
	background_secondary = "#131718";
	background_trenary = "#151A1C";
	lighter_background = "#1C2325";

	foreground_primary = "#C5C8C9";
	foreground_secondary = "#9FA0A0";
	foreground_trenary = "#6E7071";
	accent = "#7BA5DD";

	text_color = foreground_primary;
	border_color = background_trenary;
	green = "#96D6B0";
	magenta = "#CB92D2";
in
{
  programs.rofi = {
				enable = true;
				font = "DM Sans 10";

				theme = {
						"configuration" = {
							font = "DM Sans 10";
							show-icons = true;
							display-run = "Commands";
							display-drun = "Applications";
							display-window = "Windows";
							drun-display-format = "{name}";
						};

						"window" = {
							width = mkLiteral "41%";
							border = mkLiteral "0px";
							border-color = mkLiteral darker_background;
							border-radius = mkLiteral "0px";
							transparency = "real";
						};

						"prompt" = {
							enabled = false;
							text-color = mkLiteral darker_background;
							background-color = mkLiteral accent;
							border-radius = mkLiteral "6px 0px 0px 6px";
							padding = mkLiteral "1.5% 0.75%";
						};

						"entry" = {
							expand = true;
							blink = true;
							text-color = mkLiteral foreground_primary;
							background-color = mkLiteral background_trenary;
							placeholder-color = mkLiteral foreground_trenary;
							placeholder = "   Type to search... ";
							horizontal-align = mkLiteral "0.5";
							padding = mkLiteral "10px 8px";
							border = mkLiteral "0px 0px 0px 0px";
							border-radius = mkLiteral "6px";
							border-color = mkLiteral accent;
						};

						"inputbar" = {
							expand = false;
							children = map mkLiteral [ "prompt" "entry" ];
							text-color = mkLiteral darker_background;
							background-color = mkLiteral darker_background;
							padding = mkLiteral "16px";
							margin = mkLiteral "2px 1.75em";
						};

						"listview" = {
							cycle = false;
							dynamic = true;
							layout = mkLiteral "vertical";
							columns = 4;
							lines = 3;
							background-color = mkLiteral darker_background;
							padding = mkLiteral "0px 1em 1em";
							spacing = mkLiteral "0%";
						};

						"mode-switcher" = {
							background-color = mkLiteral darker_background;
							text-color = mkLiteral foreground_primary;
							margin = mkLiteral "0em 6.5em 0.75em";
						};

						"button" = {
							background-color = mkLiteral background_primary;
							text-color = mkLiteral foreground_primary;
							padding = mkLiteral "0.5em";
							margin = mkLiteral "0em 0.25em";
							border-radius = mkLiteral "6px";
						};

						"button selected" = {
							background-color = mkLiteral lighter_background;
							border = mkLiteral "0px 0px 0px 2px";
							border-color = mkLiteral green;
							border-radius = mkLiteral "6px";
						};

						"mainbox" = {
							children = map mkLiteral [ "inputbar" "listview" "mode-switcher" ];
							background-color = mkLiteral darker_background;
							spacing = mkLiteral "0%";
							border = mkLiteral "4px";
							border-color = mkLiteral border_color;
						};

						"element" = {
							orientation = mkLiteral "vertical";
							text-color = mkLiteral foreground_primary;
							background-color = mkLiteral darker_background;
							padding = mkLiteral "6px";
							border-radius = mkLiteral "6px";
						};

						"element-icon, element-text" = {
							text-color = mkLiteral "inherit";
							background-color = mkLiteral "inherit";
						};

						"element-icon" = {
							size = mkLiteral "42px";
							horizontal-align = mkLiteral "0.5";
							vertical-align = mkLiteral "0.5";
							border = mkLiteral "12px";
							border-color = mkLiteral "transparent";
						};

						"element-text" = {
							font = "DM Sans 10";
							expand = true;
							horizontal-align = mkLiteral "0.5";
							vertical-align = mkLiteral "0.5";
							margin = mkLiteral "0px 12px 8px 12px";
						};

						"element selected" = {
							text-color = mkLiteral green;
							background-color = mkLiteral lighter_background;
							border = mkLiteral "0px 0px 2px 0px";
							border-color = mkLiteral green;
						};
					};
			};
}
