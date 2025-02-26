static const char norm_fg[] = "#bbc4af";
static const char norm_bg[] = "#040F0A";
static const char norm_border[] = "#82897a";

static const char sel_fg[] = "#bbc4af";
static const char sel_bg[] = "#275743";
static const char sel_border[] = "#bbc4af";

static const char urg_fg[] = "#bbc4af";
static const char urg_bg[] = "#1D5742";
static const char urg_border[] = "#1D5742";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
