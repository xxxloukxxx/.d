/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx = 2;       /* border pixel of windows */
static const unsigned int gappx    = 0;       /* gap pixel between windows */
static const unsigned int snap     = 32;      /* snap pixel */
static const int showbar           = 1;       /* 0 means no bar */
static const int topbar            = 1;       /* 0 means bottom bar */
static const unsigned int systraypinning = 1; /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft  = 0; /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2; /* systray spacing */
static const int systraypinningfailfirst = 1; /* 1: if pinning fails, display systray on the first monitor, */
/*                                                  False: display systray on the last monitor*/
static const int showsystray  = 1; /* 0 means no systray */
static const int focusonwheel = 0;
static const char* fonts[]    = { "agave:size=12" };
static const char dmenufont[] = "agave:size=12";
// static const char* fonts[]    = { "agave:size=16" };
// static const char dmenufont[] = "agave:size=16";

static const char col_gray1[] = "#000000";
static const char col_gray2[] = "#141416";
static const char col_gray3[] = "#686868";
static const char col_gray4[] = "#ffffff";
static const char col_cyan[]  = "#090c2c";
static const char col_red[]   = "#7a0000";

static const char* colors[][3] = {
    /*               fg         bg         border   */
    [SchemeBar]    = { col_gray3, col_gray1, col_gray2 },
    [SchemeBarSel] = { col_gray4, col_cyan, col_red },
    [SchemeNorm]   = { col_gray3, col_gray1, col_gray2 },
    [SchemeSel]    = { col_gray4, col_cyan, col_red },
};

/* tagging */
// static const char* tags[] = { "Q", "W", "E", "R", "T", "Y", "U", "I", "O" };
// static const char* tags[] = { "🅀", "🅆", "🄴", "🅁", "🅃", "🅈", "🅄", "🄸", "🄾" };
static const char* tags[] = { "Q", "W", "E", "R", "T", "Y"};

static const Rule rules[] = {
    /* xprop(1):
     *  WM_CLASS(STRING) = instance, class
     *  WM_NAME(STRING) = title
     */
    /* class      instance    title       tags mask     isfloating   monitor */
    { "vesktop", NULL, NULL, 1 << 5, 0, 0 },
};

/* layout(s) */
static const float mfact        = 0.618; /* factor of master area size [0.05..0.95] */
static const int nmaster        = 1;     /* number of clients in master area */
static const int resizehints    = 1;     /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1;     /* 1 will force focus on the fullscreen window */
static const int refreshrate    = 120;   /* refresh rate (per second) for client move/resize */

static const Layout layouts[] = {
    /* symbol     arrange function */
    { "[]=", tile }, /* first entry is default */
    { "[M]", monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                        \
    { MODKEY, KEY, view, { .ui = 1 << TAG } }, { \
        MODKEY | ShiftMask, KEY, tag, {          \
            .ui = 1 << TAG                       \
        }                                        \
    }

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                     \
    {                                  \
        .v = (const char*[]) {         \
            "/bin/sh", "-c", cmd, NULL \
        }                              \
    }

/* commands */
static char dmenumon[2]           = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char* dmenucmd[]     = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3,
        "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char* termcmd[]      = { "st", NULL };
static const char* dpowercmd[]    = { "dpower", NULL };
static const char* dmocpcmd[]     = { "dmocp", NULL };
static const char* dmocpinfo[]    = { "dmocpinfo", NULL };
static const char* upvol[]        = { "vol.sh", "up", NULL };
static const char* downvol[]      = { "vol.sh", "dn", NULL };
static const char* mutevol[]      = { "vol.sh", "mute", NULL };
static const char spadname[]      = "spad";
static const char* spadcmd[]      = { "st", "-t", spadname, NULL };
static const char* spcalccmd[]    = { "st", "-t", spadname, "-g", "50x20", "-e", "bc", "-ql", NULL };
static const char* flameshotcmd[] = { "flameshot", "gui", NULL };

#include <X11/XF86keysym.h>
static const Key keys[] = {
    /* modifier, key, function, argument */

    { MODKEY, XK_d, spawn, { .v = dmenucmd } },
    { MODKEY, XK_Return, spawn, { .v = termcmd } },
    { MODKEY | ShiftMask, XK_BackSpace, spawn, { .v = dpowercmd } },
    { MODKEY, XK_m, spawn, { .v = dmocpcmd } },
    { MODKEY | ShiftMask, XK_m, spawn, { .v = dmocpinfo } },
    { MODKEY | ShiftMask, XK_s, spawn, { .v = flameshotcmd } },

    { MODKEY, XK_b, togglebar, { 0 } },

    { MODKEY, XK_Up, focusstack, { .i = -1 } },
    { MODKEY, XK_Down, focusstack, { .i = +1 } },
    { MODKEY, XK_Left, focusstack, { .i = -1 } },
    { MODKEY, XK_Right, focusstack, { .i = +1 } },

    { MODKEY, XK_j, incnmaster, { .i = +1 } },
    { MODKEY, XK_k, incnmaster, { .i = -1 } },

    { MODKEY | ShiftMask, XK_j, setmfact, { .f = -0.05 } },
    { MODKEY | ShiftMask, XK_k, setmfact, { .f = +0.05 } },
    { MODKEY | ShiftMask, XK_h, setmfact, { .f = +1.618 } },

    { MODKEY | ShiftMask, XK_Return, zoom, { 0 } },

    { MODKEY | ShiftMask, XK_c, killclient, { 0 } },
    { MODKEY, XK_f, setlayout, { 0 } },

    { MODKEY, XK_p, focusmon, { .i = +1 } },
    { MODKEY | ShiftMask, XK_p, tagmon, { .i = +1 } },

    /* --- adajacent-tag --- */
    { MODKEY, XK_a, viewnext, { 0 } },
    /* --- adajacent-tag --- */

    /* --- scratchpad --- */
    { MODKEY, XK_Escape, togglescratch, { .v = spadcmd } },
    { MODKEY, XK_c, togglescratch, { .v = spcalccmd } },
    /* --- scratchpad --- */

    /* --- volume --- */
    { 0, XF86XK_AudioRaiseVolume, spawn, { .v = upvol } },
    { 0, XF86XK_AudioLowerVolume, spawn, { .v = downvol } },
    { 0, XF86XK_AudioMute, spawn, { .v = mutevol } },
    /* --- volume --- */

    TAGKEYS (XK_q, 0),
    TAGKEYS (XK_w, 1),
    TAGKEYS (XK_e, 2),
    TAGKEYS (XK_r, 3),
    TAGKEYS (XK_t, 4),
    TAGKEYS (XK_y, 5),
    TAGKEYS (XK_u, 6),
    TAGKEYS (XK_i, 7),
    TAGKEYS (XK_o, 8),
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
    /* click                event mask      button          function argument */
    // { ClkLtSymbol, 0, Button1, setlayout, { 0 } },
    // { ClkLtSymbol, 0, Button3, setlayout, { .v = &layouts[2] } },
    { ClkWinTitle, 0, Button2, zoom, { 0 } },
    // { ClkStatusText, 0, Button2, spawn, { .v = termcmd } },
    { ClkClientWin, MODKEY, Button1, movemouse, { 0 } },
    // { ClkClientWin, MODKEY, Button2, togglefloating, { 0 } },
    { ClkClientWin, MODKEY, Button3, resizemouse, { 0 } }, { ClkTagBar, 0, Button1, view, { 0 } },
    // { ClkTagBar, 0, Button3, toggleview, { 0 } },
    // { ClkTagBar, MODKEY, Button1, tag, { 0 } },
    // { ClkTagBar, MODKEY, Button3, toggletag, { 0 } },
};
