{
  lib,
  pkgs,
  config,
  username,
  ...
}:
with lib;
with pkgs;
let

  one = "plus";
  two = "bracketleft";
  three = "braceleft";
  four = "parenleft";
  five = "ampersand";
  six = "equal";
  seven = "parenright";
  eight = "braceright";
  nine = "bracketright";
  ten = "asterisk";

  mod4 = "Mod4";
  output = "DSI-1";
  laptop = [
    "DSI-1"
    "eDP-1"
  ];
  opacity = "1";

  left = "h";
  down = "j";
  up = "k";
  right = "l";

in
{
  services.swayidle.enable = true;
  services.swayidle.timeouts = [
    {
      timeout = 150;
      command = "${sway}/bin/swaymsg 'output * dpms off'";
      resumeCommand = "${sway}/bin/swaymsg 'output * dpms on'";
    }
  ];
  home.packages = with pkgs; [
    swaybg
    mako
  ];
  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    extraConfigEarly = ''
      include temp
      input "type:keyboard" xkb_layout real-prog-dvorak,ru
    '';
    checkConfig = false;
    config = {
      bindswitches = {
        "lid:on" = {
          reload = true;
          locked = true;
          action = concatStringsSep ";" (map (x: "output ${x} disable") laptop);
        };
        "lid:off" = {
          reload = true;
          locked = true;
          action = concatStringsSep ";" (map (x: "output ${x} enable") laptop);
        };
      };

      output.${output}.scale = "2";
      output."eDP-1".disable = "";
      output."DP-5".position = "0,0";
      output."DP-4".position = "0,1080";

      modifier = mod4;
      bars = [
        {
          command = "${waybar}/bin/waybar";
        }
      ];
      focus.forceWrapping = false;
      focus.followMouse = true;

      fonts.names = [ config.my.font ];
      fonts.size = toString config.my.font-size;

      gaps.inner = 4;

      startup = [
        { command = "${alacritty}/bin/alacritty"; }
        { command = "~/.local/bin/bg.sh"; }
        # { command = "bg.sh"; }
      ];

      input."type:keyboard" = {
        xkb_options = "caps:swapescape,grp:rctrl_toggle";
        repeat_delay = "500";
        repeat_rate = "50";
        events = "enabled";
      };

      workspaceOutputAssign = [
        {
          output = "DP-4";
          workspace = "term";
        }
        {
          output = "DP-4";
          workspace = "1";
        }
        {
          output = "DP-4";
          workspace = "2";
        }
        {
          output = "DP-4";
          workspace = "3";
        }
        {
          output = "DP-4";
          workspace = "4";
        }
        {
          output = "DP-4";
          workspace = "5";
        }
        {
          output = "DP-5";
          workspace = "6";
        }
        {
          output = "DP-5";
          workspace = "7";
        }
        {
          output = "DP-5";
          workspace = "8";
        }
      ];

      window.border = 2;
      window.titlebar = false;

      window.commands = [
        {
          command = "opacity 0.95";
          criteria.app_id = "alacritty";
        }
        {
          command = "floating enable, sticky enable";
          criteria.title = "Picture-in-Picture";
        }
      ];

      assigns.term = [ { app_id = "Alacritty"; } ];
      assigns."1" = [ { app_id = "emacs"; } ];
      assigns."3" = [
        { app_id = "firefox"; }
      ];
      assigns."4" = [
        { app_id = "thunderbind"; }
      ];
      assigns."6" = [
        { app_id = "inkscape"; }
        { app_id = "gimp*"; }
        { class = "krita"; }
      ];
      assigns."7" = [ { app_id = "libreoffice-*"; } ];
      assigns."8" = [
        { app_id = "vesktop"; }
      ];
      assigns."9" = [
      ];
      assigns."10" = [
      ];

      floating.modifier = mod4;
      floating.border = 2;
      floating.titlebar = false;

      floating.criteria = [
        { app_id = ".*blueman-manager-wrapped"; }
        { app_id = ".*scrcpy-wrapped"; }
        { app_id = ".blueman-sendto-wrapped"; }
        { app_id = ".*zathura"; }
        { app_id = "imv"; }
        { app_id = "mpv"; }
        {
          app_id = "Thunar";
          title = "Rename.*";
        }
        {
          app_id = "Thunar";
          title = "File Operation Progress";
        }
        { app_id = "system-config-printer"; }
        { app_id = "xdg-desktop-portal-gtk"; }
      ];

      keybindings = mkOptionDefault {
        "${mod4}+d" = "exec ${fuzzel}/bin/fuzzel";
        "${mod4}+p" = ''exec ${grim}/bin/grim -g "$(${slurp}/bin/slurp)" - | ${wl-clipboard}/bin/wl-copy'';
        "${mod4}+z" = "exec firefox";
        "${mod4}+Ctrl+u" = "exec Thunar";
        "${mod4}+Ctrl+a" = "exec pwvucontrol";
        "${mod4}+Shift+v" = "exec cliphist-fuzzel-img";

        "${mod4}+Shift+Return" = "exec ${alacritty}/bin/alacritty";
        "${mod4}+Ctrl+e" = "exec emacsclient --alternate-editor=\"\" --create-frame ";
        "${mod4}+w" = "layout tabbed";

        "Print" = "mode printscreen";
        "Shift+Delete" = "mode session";

        "${mod4}+b" =
          "exec ${wl-kbptr}/bin/wl-kbptr -o modes=floating','click -o mode_floating.source=detect";

        "${mod4}+${one}" = "workspace number 1";
        "${mod4}+${two}" = "workspace number 2";
        "${mod4}+${three}" = "workspace number 3";
        "${mod4}+${four}" = "workspace number 4";
        "${mod4}+${five}" = "workspace number 5";
        "${mod4}+${six}" = "workspace number 6";
        "${mod4}+${seven}" = "workspace number 7";
        "${mod4}+${eight}" = "workspace number 8";
        "${mod4}+${nine}" = "workspace number 9";
        "${mod4}+${ten}" = "workspace number 10";
        "${mod4}+Return" = "workspace term";

        "${mod4}+Shift+period" = "move container to workspace next; workspace next";
        "${mod4}+Shift+comma" = "move container to workspace prev; workspace prev";

        "${mod4}+1" = "move container to workspace number 1";
        "${mod4}+2" = "move container to workspace number 2";
        "${mod4}+3" = "move container to workspace number 3";
        "${mod4}+4" = "move container to workspace number 4";
        "${mod4}+7" = "move container to workspace number 7";
        "${mod4}+8" = "move container to workspace number 8";
        "${mod4}+9" = "move container to workspace number 9";
        "${mod4}+0" = "move container to workspace number 10";

        "${mod4}+${left}" = "focus left";
        "${mod4}+${down}" = "focus down";
        "${mod4}+${up}" = "focus up";
        "${mod4}+${right}" = "focus right";

        "${mod4}+Ctrl+${left}" = "move workspace to output left";
        "${mod4}+Ctrl+${down}" = "move workspace to output down";
        "${mod4}+Ctrl+${up}" = "move workspace to output up";
        "${mod4}+Ctrl+${right}" = "move workspace to output right";

        "${mod4}+Shift+${left}" = "move left";
        "${mod4}+Shift+${down}" = "move down";
        "${mod4}+Shift+${up}" = "move up";
        "${mod4}+Shift+${right}" = "move right";

        "XF86AudioRaiseVolume" = "exec ${wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec ${wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "${mod4}+XF86AudioMute" = "exec ${wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        "XF86MonBrightnessUp" = "exec ${brightnessctl}/bin/brightnessctl s 10%+";
        "XF86MonBrightnessDown" = "exec ${brightnessctl}/bin/brightnessctl s 10%-";
      };

      colors.background = config.my.theme.colors.background;

      colors.focused = {
        border = config.my.theme.colors.blue;
        background = config.my.theme.colors.background;
        text = config.my.theme.colors.foreground;
        indicator = config.my.theme.colors.blue;
        childBorder = config.my.theme.colors.blue;
      };

      colors.focusedInactive = {
        border = config.my.theme.colors.brightBlack;
        background = config.my.theme.colors.background;
        text = config.my.theme.colors.foreground;
        indicator = config.my.theme.colors.brightBlack;
        childBorder = config.my.theme.colors.brightBlack;
      };

      colors.unfocused = {
        border = config.my.theme.colors.black;
        background = config.my.theme.colors.background;
        text = config.my.theme.colors.foreground;
        indicator = config.my.theme.colors.black;
        childBorder = config.my.theme.colors.black;
      };

      colors.urgent = {
        border = config.my.theme.colors.red;
        background = config.my.theme.colors.background;
        text = config.my.theme.colors.foreground;
        indicator = config.my.theme.colors.red;
        childBorder = config.my.theme.colors.red;
      };

      colors.placeholder = {
        border = config.my.theme.colors.brightBlack;
        background = config.my.theme.colors.background;
        text = config.my.theme.colors.foreground;
        indicator = config.my.theme.colors.brightBlack;
        childBorder = config.my.theme.colors.brightBlack;
      };

      modes.resize = {
        Escape = "mode default";
        Return = "mode default";
        "${down}" = "resize grow height 5 px or 5 ppt";
        "${left}" = "resize shrink width 5 px or 5 ppt";
        "${right}" = "resize grow width 5 px or 5 ppt";
        "${up}" = "resize shrink height 5 px or 5 ppt";
      };

      modes.session = {
        Escape = "mode default";
        Return = "mode default";
        "Delete" = "exec ${systemd}/bin/systemctl poweroff, mode default";
        "r" = "exec ${systemd}/bin/systemctl reboot, mode default";
        "l" = "exec ${swaylock}/bin/swaylock, mode default";
        "e" = "exec ${sway}/bin/swaymsg exit, mode default";
      };
    };
  };
}
