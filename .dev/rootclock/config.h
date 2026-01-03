/* Appearance */
static const char *bg_color = "#000000";

/* Background handling */
enum background_mode_cfg {
  BG_MODE_SOLID,
  BG_MODE_COPY,
  BG_MODE_INVERT,
  BG_MODE_MULTIPLY,
  BG_MODE_SCREEN,
  BG_MODE_OVERLAY,
  BG_MODE_DARKEN,
  BG_MODE_LIGHTEN,
};
// static const int background_mode = BG_MODE_LIGHTEN;
// static const int background_mode = BG_MODE_SOLID;
static const int background_mode = BG_MODE_COPY;
static const int block_padding_x = 48;
static const int block_padding_y = 24;

/* Time (1st line) */
static const char *time_fonts[] = {
    "Agave:style=ExtraBold:size=60",
    // "Agave:style=ExtraBold:size=120",
    // "Inter:style=ExtraBold:size=120", "Liberation Sans:style=Bold:size=120",
    // "Noto Sans Math:style=Regular:size=120", /* fallback for ratio symbol */
};
// static const char *time_color = "#333333";
static const char *time_color = "#555555";
static const char *time_fmt = "%-H\xe2\x88\xb6%M";

/* Date (2nd line; set show_date=0 to disable) */
static const int show_date = 1;
static const char *date_fonts[] = {
    "Agave:style=Regular:size=26",
    // "Inter:style=Regular:size=26",
    // "Liberation Sans:style=Regular:size=26",
    // "Noto Sans:style=Regular:size=26",
};
// static const char *date_color = "#222222";
static const char *date_color = "#555555";
static const char *date_fmt = "%A, %-d %B %Y";

/* Refresh interval (seconds) */
static const int refresh_sec = 1;

/* Vertical layout */
static const int block_y_off = 0;   /* shift entire block (time+date) in px */
static const int line_spacing = 12; /* gap between time and date in px */
