{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:

let
  sansSerifFont = osConfig.stylix.fonts.sansSerif.name;
  monospaceFont = osConfig.stylix.fonts.monospace.name;
in
{
  home.packages = [ pkgs.equibop ];

  xdg.configFile."equibop/themes/midnight.css".text = ''
    /* import theme modules */
    @import url('https://refact0r.github.io/midnight-discord/build/midnight.css');

    body {
        /* font options */
        --font: '${sansSerifFont}'; /* change to "" for default discord font */
        --code-font: '${monospaceFont}'; /* change to "" for default discord font */
        font-weight: 400; /* normal text font weight. DOES NOT AFFECT BOLD TEXT */

        /* sizes */
        --gap: 8px; /* spacing between panels */
        --divider-thickness: 4px; /* thickness of unread messages divider and highlighted message borders */
        --border-thickness: 1px; /* thickness of borders around main panels. DOES NOT AFFECT OTHER BORDERS */

        /* animation/transition options */
        --animations: on; /* off: disable animations/transitions, on: enable animations/transitions */
        --list-item-transition: 0.1s ease; /* transition for list items */
        --dms-icon-svg-transition: 0.6s ease; /* transition for the dms icon */
        --border-hover-transition: 0.2s ease; /* transition for borders when hovered */

        /* top bar options */
        --top-bar-height: var(--gap); /* height of the top bar (discord default is 36px, old discord style is 24px, var(--gap) recommended if button position is set to titlebar) */
        --top-bar-button-position: titlebar; /* off: default position, hide: hide buttons completely, serverlist: move inbox button to server list, titlebar: move inbox button to channel titlebar (will hide title) */
        --top-bar-title-position: off; /* off: default centered position, hide: hide title completely, left: left align title (like old discord) */
        --subtle-top-bar-title: off; /* off: default, on: hide the icon and use subtle text color (like old discord) */

        /* window controls */
        --custom-window-controls: off; /* off: default window controls, on: custom window controls */
        --window-control-size: 14px; /* size of custom window controls */

        /* dms button options */
        --custom-dms-icon: custom; /* off: use default discord icon, hide: remove icon entirely, custom: use custom icon */
        --dms-icon-svg-url: url('https://refact0r.github.io/midnight-discord/assets/Font_Awesome_5_solid_moon.svg'); /* icon svg url. MUST BE A SVG. */
        --dms-icon-svg-size: 90%; /* size of the svg (css mask-size property) */
        --dms-icon-color-before: var(--icon-secondary); /* normal icon color */
        --dms-icon-color-after: var(--white); /* icon color when button is hovered/selected */
        --custom-dms-background: off; /* off to disable, image to use a background image (must set url variable below), color to use a custom color/gradient */
        --dms-background-image-url: url(""); /* url of the background image */
        --dms-background-image-size: cover; /* size of the background image (css background-size property) */
        --dms-background-color: linear-gradient(70deg, var(--blue-2), var(--purple-2), var(--red-2)); /* fixed color/gradient (css background property) */

        /* background image options */
        --background-image: off; /* off: no background image, on: enable background image (must set url variable below) */
        --background-image-url: url(""); /* url of the background image */

        /* transparency/blur options */
        /* NOTE: TO USE TRANSPARENCY/BLUR, YOU MUST HAVE TRANSPARENT BG COLORS. FOR EXAMPLE: --bg-4: hsla(220, 15%, 10%, 0.7); */
        --transparency-tweaks: on; /* off: no changes, on: remove some elements for better transparency */
        --remove-bg-layer: off; /* off: no changes, on: remove the base --bg-3 layer for use with window transparency (WILL OVERRIDE BACKGROUND IMAGE) */
        --panel-blur: on; /* off: no changes, on: blur the background of panels */
        --blur-amount: 8px; /* amount of blur */
        --bg-floating: var(--bg-3); /* set this to a more opaque color if floating panels look too transparent. only applies if panel blur is on  */

        /* chatbar options */
        --custom-chatbar: aligned; /* off: default chatbar, aligned: chatbar aligned with the user panel, separated: chatbar separated from chat */
        --chatbar-height: 56px; /* height of the chatbar (52px by default, 47px recommended for aligned, 56px recommended for separated) */
        --chatbar-padding: 8px; /* padding of the chatbar. only applies in aligned mode. */

        /* other options */
        --small-user-panel: off; /* off: default user panel, on: smaller user panel like in old discord */
    }

    /* color options */
    :root {
        --colors: on; /* off: discord default colors, on: midnight custom colors */

        /* text colors */
        --text-0: var(--bg-4); /* text on colored elements */
        --text-1: hsl(43.16, 58.76%, 80.98%); /* other normally white text */
        --text-2: hsl(38, 41.1%, 71.37%); /* headings and important text */
        --text-3: hsl(35, 17.14%, 58.82%); /* normal text */
        --text-4: hsl(27.5, 10.71%, 43.92%); /* icon buttons and channels */
        --text-5: hsl(26.67, 9.68%, 36.47%); /* muted channels/chats and timestamps */

        /* background and dark colors */
        --bg-1: hsla(21.82, 7.38%, 29.22%, 1); /* dark buttons when clicked */
        --bg-2: hsla(20, 5.26%, 22.35%, 1); /* dark buttons */
        --bg-3: hsla(20, 3.09%, 19.02%, 1); /* spacing, secondary elements */
        --bg-4: hsla(0, 0%, 16%, 0.95); /* main background color */
        --hover: hsla(35, 17%, 59%, 0.1); /* channels and buttons when hovered */
        --active: hsla(35, 17%, 59%, 0.2); /* channels and buttons when clicked or selected */
        --active-2: hsla(35, 17%, 59%, 0.3); /* extra state for transparent buttons */
        --message-hover: hsla(35, 17%, 59%, 0.05); /* messages when hovered */

        /* accent colors */
        --accent-1: var(--green-1); /* links and other accent text */
        --accent-2: var(--green-2); /* small accent elements */
        --accent-3: var(--green-3); /* accent buttons */
        --accent-4: var(--green-4); /* accent buttons when hovered */
        --accent-5: var(--green-5); /* accent buttons when clicked */
        --accent-new: var(--accent-2); /* stuff that's normally red like mute/deafen buttons */
        --mention: linear-gradient(to right, color-mix(in hsl, var(--accent-2), transparent 90%) 40%, transparent); /* background of messages that mention you */
        --mention-hover: linear-gradient(to right, color-mix(in hsl, var(--accent-2), transparent 95%) 40%, transparent); /* background of messages that mention you when hovered */
        --reply: linear-gradient(to right, color-mix(in hsl, var(--text-3), transparent 90%) 40%, transparent); /* background of messages that reply to you */
        --reply-hover: linear-gradient(to right, color-mix(in hsl, var(--text-3), transparent 95%) 40%, transparent); /* background of messages that reply to you when hovered */

        /* status indicator colors */
        --online: var(--green-2); /* change to #40a258 for default */
        --dnd: var(--red-2); /* change to #d83a41 for default */
        --idle: var(--yellow-2); /* change to #cc954c for default */
        --streaming: var(--purple-2); /* change to ##9147ff for default */
        --offline: var(--text-4); /* change to #82838b for default offline color */

        /* border colors */
        --border-light: var(--hover); /* general light border color */
        --border: var(--active); /* general normal border color */
        --border-hover: var(--active); /* border color of panels when hovered */
        --button-border: hsl(220, 0%, 100%, 0.1); /* neutral border color of buttons */

        /* base colors */
        --red-1: oklch(65.97% 0.2175 30.39);
        --red-2: oklch(67.68% 0.1615 25.42);
        --red-3: oklch(54.58% 0.203 28.66);
        --red-4: oklch(43.74% 0.1789 28.26);
        --red-5: oklch(37.33% 0.1462 30.21);

        --green-1: oklch(76.52% 0.1581 110.83);
        --green-2: oklch(74.78% 0.1066 116.53);
        --green-3: oklch(65.64% 0.1354 109.12);
        --green-4: oklch(54.63% 0.1124 106.46);
        --green-5: oklch(45.31% 0.0943 109.64);

        --blue-1: oklch(69.27% 0.042 169.77);
        --blue-2: oklch(71.28% 0.0546 179.19);
        --blue-3: oklch(57.56% 0.0658 199.49);
        --blue-4: oklch(47.06% 0.0816 215.81);
        --blue-5: oklch(38.61% 0.0633 217.12);

        --yellow-1: oklch(83.25% 0.1595 82.99);
        --yellow-2: oklch(75.58% 0.1133 77.04);
        --yellow-3: oklch(72.51% 0.1429 77.71);
        --yellow-4: oklch(61.76% 0.1277 70.67);
        --yellow-5: oklch(51.25% 0.1109 69.12);

        --purple-1: oklch(70.54% 0.0976 2.19);
        --purple-2: var(--purple-1);
        --purple-3: oklch(59.73% 0.1105 352.22);
        --purple-4: oklch(48.93% 0.1242 344.28);
        --purple-5: oklch(40.12% 0.1097 340.29);
    }
  '';

  xdg.configFile."equibop/themes/snippets.css".text = ''
    @import url("https://raw.githubusercontent.com/Augenbl1ck/Discord-Styles/refs/heads/main/expProfile.css");

    /* readd timestamp tooltips */
    time[datetime]:hover::after {
      content: "("attr(datetime)")";
      width: max-content;
      position: absolute;
      z-index: 9999;
      backdrop-filter: blur(4px);
      padding: 0 4px;
      border-radius: 6px;
    }

    /* swap clan tag and role icons */
    [class^="headerText"] {
        display: inline-flex;
        & > span:has([class^="roleicon"]){
            order: 2;
        }
        & > span:has([class^="chipletContainerInner"]){
            order: 3;
        }
        & > span[style="display: none;"]{
            order: 4;
        }
        & > .vc-message-decorations-wrapper {
            order: 5;
        }
        & > span:has(> [class^="newMemberBadge"]){
            order: 6;
        }
        & > span:is([class^="botTag"]){
            order: 7;
        }
    }
  '';
}
