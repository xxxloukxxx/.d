/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar  = 1; /* -b  option; if 0, dmenu appears at bottom     */
static int instant = 1; /* -n  option; if 1, select single entry automatically */
static int fuzzy   = 1; /* -F  option; if 0, dmenu doesn't use fuzzy matching */

/* -fn option overrides fonts[0]; default X11 font or font set */
static const char* fonts[]               = { "agave:size=16" };
static const char* prompt                = NULL; /* -p  option; prompt to the left of input field */
static const char* colors[SchemeLast][2] = {
    /*     fg         bg       */
    // [SchemeNorm]          = { "#c7c7c7", "#01060e" },
    // [SchemeSel]           = { "#ffffff", "#036daa" },
    // [SchemeOut]           = { "#01060e", "#0c0c9b" },
    // [SchemeSelHighlight]  = { "#ffffff", "#005c00" },
    // [SchemeNormHighlight] = { "#bbbbbb", "#003c00" },
    // [SchemeNorm]          = { "#5c5c5c", "#161821" },
    [SchemeNorm]          = { "#686868", "#000000" },
    [SchemeSel]           = { "#ffffff", "#090c2c" },
    [SchemeOut]           = { "#000000", "#392c5c" },
    [SchemeSelHighlight]  = { "#ffffff", "#004c00" },
    [SchemeNormHighlight] = { "#686868", "#002c00" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
