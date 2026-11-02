var previousFont = draw_get_font();
var previousColor = draw_get_color();
var previousAlpha = draw_get_alpha();
var previousHalign = draw_get_halign();
var previousValign = draw_get_valign();
draw_set_font(fnt_button);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);

var guiWidth = display_get_gui_width();
var guiHeight = display_get_gui_height();
var boxWidth = min(800, guiWidth*0.84);
var boxHeight = min(720, guiHeight*0.84);
var boxX = (guiWidth-boxWidth)/2;
var boxY = (guiHeight-boxHeight)/2;
draw_rectangle_color(0, 0, guiWidth, guiHeight, c_black, c_black, c_black, c_black, false);
draw_sprite_ext(MenuSprite, 0, boxX, boxY, boxWidth/sprite_get_width(MenuSprite),
    boxHeight/sprite_get_height(MenuSprite), 0, c_white, 1);
draw_set_color(c_white);
draw_text_transformed(boxX+28, boxY+24, "About", 2.4, 2.4, 0);

var textScale = 1.5;
var wrapWidth = (boxWidth-56)/textScale;
var textHeight = max(20, boxHeight-176);
// Split into pages using the same word-wrap width as the drawing call.
var words = string_split(aboutText, " ");
var pages = [];
var pageText = "";
for (var i = 0; i < array_length(words); i++)
{
    var candidate = pageText == "" ? words[i] : pageText+" "+words[i];
    if (pageText != "" and string_height_ext(candidate, 20, wrapWidth)*textScale > textHeight)
    {
        array_push(pages, pageText);
        pageText = words[i];
    }
    else pageText = candidate;
}
array_push(pages, pageText);
pageCount = array_length(pages);
pageIndex = clamp(pageIndex, 0, pageCount-1);
draw_text_ext_transformed(boxX+28, boxY+84, pages[pageIndex], 20, wrapWidth,
    textScale, textScale, 0);
if (pageCount > 1)
    draw_text_transformed(boxX+28, boxY+boxHeight-56,
        string_concat(pageIndex+1, "/", pageCount, "  Arrow keys / mouse wheel"), 1.1, 1.1, 0);

draw_sprite_ext(MenuSprite, 0, boxX+boxWidth-164, boxY+boxHeight-64,
    140/sprite_get_width(MenuSprite), 44/sprite_get_height(MenuSprite), 0, c_white, 1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed(boxX+boxWidth-94, boxY+boxHeight-42, "Close", 1.5, 1.5, 0);

draw_set_font(previousFont);
draw_set_color(previousColor);
draw_set_alpha(previousAlpha);
draw_set_halign(previousHalign);
draw_set_valign(previousValign);
