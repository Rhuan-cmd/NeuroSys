display_set_gui_size(960, 540);
if (surface_exists(application_surface)) surface_resize(application_surface, variable_global_exists("fx_surface_w") ? global.fx_surface_w : 960, variable_global_exists("fx_surface_h") ? global.fx_surface_h : 540);
