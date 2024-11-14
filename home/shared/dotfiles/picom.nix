{pkgs, ...}: {
    services.picom = {
				enable = true;
				#package = pkgs.picom-pijulius;
        package = pkgs.picom;

				backend = "glx";
				shadow = true;
				shadowOpacity = 0.55;
				shadowOffsets = [ 
					(-20) 
					(-20)
				];
				shadowExclude = [
					"_GTK_FRAME_EXTENTS@:c"
					"class_g = 'Dunst'"
					"class_g = 'Eww'"
					"class_g = 'firefox' && argb"
				];
				fade = false;
				fadeSteps = [ 0.06 0.06 ];
				fadeDelta = 10;
				inactiveOpacity = 1.0;
				activeOpacity = 1.0;
				vSync = true;
				wintypes = {
					dialog = { shadow = false; };
					dnd = { shadow = false; };
					dropdown_menu = { shadow = false; };
					menu = { shadow = false; full-shadow = true; };
					popup_menu = { shadow = false; full-shadow = true; };
					tooltip = { fade = true; shadow = true; full-shadow = false; };
					utility = { shadow = false; };
				};

				settings = {
					animations = true;
					animation = {
						stiffness = 300.0;
						dampening = 28.0;
						clamping = true;
						mass = 2;
						for-open-window = "zoom";
						for-menu-window = "slide-zoom";
						for-transient-window = "zoom";
						for-workspace-switch-in = "slide-down";
						for-workspace-switch-out = "slide-up";
					};

					transition = {
						enable = true;
						offset = 20;
						direction = "smart-x";
						step = 0.036;
						rule = [
    							"none: window_type = 'dialog'"
    							"none: window_type = 'menu'"
							"none: window_type = 'dropdown_menu'"
    							"none: window_type = 'popup_menu'"
    							"none: window_type = 'tooltip'"
    							"none: class_g ?= 'eww-control-center"
    							"smart-x: class_g = 'Dunst'"
    							"smart-y: class_g ?= 'rofi'"
    							"smart-y: class_g ?= 'eww-calendar'"
    							"smart-y: class_g ?= 'eww-notification-popup'"
						];
						
						corner-radius = 10;
						rounded-corners-exclude = [
    							"window_type = 'normal'"
    							"window_type = 'dialog'" 
    							"window_type = 'menu'"
    							"window_type = 'dropdown_menu'"
    							"window_type = 'popup_menu'"
    							"class_g = 'Dunst'"
    							"class_g = 'Gimp-2.10'"
    							"class_g ?= 'eww-bar'"
						];

						shadow-radius = 20;
						frame-opacity = 1.0;
						inactive-opacity-override = false;

						blur = {
							method = "none";
							size = 14;
							strength = 10;
							background = {
								enable = false;
								frame = false;
								fixed = false;
								exclude = [
									"name *= 'slop'"
    									"window_type = 'dock'"
    									"window_type = 'desktop'"
    									"_GTK_FRAME_EXTENTS@:c"
								];
							};
						};
						mark-wmwin-focused = true;
						mark-ovredir-focused = true;
						detect = {
							rounded-corners = true;
							client-opacity = true;
							transient = true;
							client-leader = true;
						};
						refresh-rate = 0;
						use-damage = true;
						log-level = "warn";
					};
				};

			};
		}
