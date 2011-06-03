/* See LICENSE file for copyright and license details. */

/* appearance */
#define NUMCOLORS         4             // need at least 3
static const char colors[NUMCOLORS][ColLast][8] = {
   // border   foreground  background
   { "#121212", "#cccccc", "#121212" },  // 0 = normal
   { "#cccccc", "#121212", "#cccccc" },  // 1 = selected
   { "#0066ff", "#0066ff", "#ffffff" },  // 2 = urgent/warning
   { "#ff0000", "#ffffff", "#ff0000" },  // 3 = error
   // add more here
};
/*static const char font[]            = "-*-terminus-medium-r-*-*-16-*-*-*-*-*-*-*";*/
static const char font[]            = "-*-tamsyn-medium-*-*-*-17-*-*-*-*-*-iso8859-*";
/*static const char normbordercolor[] = "#121212";
static const char normbgcolor[]     = "#999999";
static const char normfgcolor[]     = "#E6E6E6";
static const char selbordercolor[]  = "#121212";
static const char selbgcolor[]      = "#121212";
static const char selfgcolor[]      = "#E6E6E6";*/
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */

static const Rule rules[] = {
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            True,        -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       False,       -1 },
};

/* layout(s) */
static const float mfact        = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster        = 2;    /* default number of clients in the master area */
static const unsigned int gappx = 4;    /* gap pixel between windows */
static const Bool resizehints   = True; /* True means respect size hints in tiled resizals */

#include "nbstack.c"

static const Layout layouts[] = {
	/* symbol add gaps  arrange function */
	{ "=]",  True,     ntile   },    /* first entry is default */
	{ "><>",  False,    NULL    },    /* no layout function means floating behavior */
	{ "[M]",  False,    monocle },
  { "T2T",  True,     nbstack },
};

/* tagging */
static const Tag tags[] = {
  /* name       layout        mfact   nmaster */
  { "[term]",     &layouts[0],  -1,     -1 },
  { "[web]",      &layouts[2],  -1,     -1 },
  { "[irc/music]",      &layouts[0],  -1,      1 },
  { "[im]",       &layouts[1],   0.75,  -1 },
  { "[dl]",  		&layouts[0],  -1      -1 },
  { "[media]",    &layouts[1],  -1      -1 },
  { "[other]",    &layouts[0],  -1,     -1 },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", colors[0][ColBG], "-nf", colors[0][ColFG],"-sb", colors[1][ColBG], "-sf", colors[1][ColFG], NULL };
static const char *termcmd[]  = { "uxterm", NULL };

#include "push.c"

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
/*	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },*/
	{ MODKEY|ControlMask,           XK_j,      pushdown,       {0} },
    { MODKEY|ControlMask,           XK_k,      pushup,         {0} },
/*	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },*/
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
