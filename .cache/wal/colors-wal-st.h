const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#040F0A", /* black   */
  [1] = "#1D5742", /* red     */
  [2] = "#275743", /* green   */
  [3] = "#346C4E", /* yellow  */
  [4] = "#536C4F", /* blue    */
  [5] = "#3D8555", /* magenta */
  [6] = "#608B65", /* cyan    */
  [7] = "#bbc4af", /* white   */

  /* 8 bright colors */
  [8]  = "#82897a",  /* black   */
  [9]  = "#1D5742",  /* red     */
  [10] = "#275743", /* green   */
  [11] = "#346C4E", /* yellow  */
  [12] = "#536C4F", /* blue    */
  [13] = "#3D8555", /* magenta */
  [14] = "#608B65", /* cyan    */
  [15] = "#bbc4af", /* white   */

  /* special colors */
  [256] = "#040F0A", /* background */
  [257] = "#bbc4af", /* foreground */
  [258] = "#bbc4af",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
