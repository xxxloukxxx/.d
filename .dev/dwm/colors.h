#define C_DRACULA


#if defined(C_SORBET)

static const char col_gray1[] = "#161821";
static const char col_gray2[] = "#ff0000";
static const char col_gray3[] = "#5c5c5c";
static const char col_gray4[] = "#ffffff";
static const char col_cyan[]  = "#003c5c";

#elif defined(C_THEME1)

static const char col_gray1[] = "#040404";
static const char col_gray2[] = "#595959";
static const char col_gray3[] = "#a1a1a1";
static const char col_gray4[] = "#040404";
static const char col_cyan[]  = "#f59542";

#elif defined(C_DRACULA)

static const char col_gray1[] = "#282a36";
static const char col_gray2[] = "#ffb86c";
static const char col_gray3[] = "#ff79c6";
static const char col_gray4[] = "#ffb86c";
static const char col_cyan[]  = "#282a36";

#else

static const char col_gray1[] = "#222222";
static const char col_gray2[] = "#444444";
static const char col_gray3[] = "#bbbbbb";
static const char col_gray4[] = "#eeeeee";
static const char col_cyan[]  = "#005577";

#endif
