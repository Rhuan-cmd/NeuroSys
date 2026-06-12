var _pixel_nivel = variable_global_exists("fx_pixel_perfect_nivel") ? clamp(global.fx_pixel_perfect_nivel, 0, 2) : 0;
var _qualidade = variable_global_exists("fx_qualidade") ? clamp(global.fx_qualidade, 0, 2) : 2;

if (!surface_exists(application_surface)) {
    exit;
}

var _div = 1;
if (_qualidade == 1) _div = 2;
if (_qualidade == 0) _div = 4;
if (_pixel_nivel == 1) _div = max(_div, 2);
if (_pixel_nivel == 2) _div = max(_div, 3);

if (_div <= 1) {
    gpu_set_texfilter(true);
    exit;
}

var _src_w = surface_get_width(application_surface);
var _src_h = surface_get_height(application_surface);
var _dst_w = max(1, floor(_src_w / _div));
var _dst_h = max(1, floor(_src_h / _div));

if (!surface_exists(fx_post_surface) || fx_post_w != _dst_w || fx_post_h != _dst_h) {
    if (surface_exists(fx_post_surface)) surface_free(fx_post_surface);
    fx_post_surface = surface_create(_dst_w, _dst_h);
    fx_post_w = _dst_w;
    fx_post_h = _dst_h;
}

surface_set_target(fx_post_surface);
draw_clear_alpha(c_black, 0);
gpu_set_texfilter(_pixel_nivel <= 0 && _qualidade >= 2);
draw_surface_stretched(application_surface, 0, 0, _dst_w, _dst_h);
surface_reset_target();

gpu_set_texfilter(false);
draw_surface_stretched(fx_post_surface, 0, 0, window_get_width(), window_get_height());

// No nivel baixo, a GUI/textos posteriores voltam suaves; no alto ficam pixelados tambem.
gpu_set_texfilter(_pixel_nivel <= 1 && _qualidade >= 2);
