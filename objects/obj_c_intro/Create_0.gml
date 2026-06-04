gpu_set_texfilter(false);
display_set_gui_size(960, 540);
if (surface_exists(application_surface)) {
    surface_resize(application_surface, 960, 540);
}

intro_timer = 0;
intro_black_start = room_speed;
intro_ifma_start = intro_black_start;
intro_ifma_end = intro_ifma_start + room_speed * 6;
intro_gm_start = intro_ifma_end;
intro_gm_end = intro_gm_start + room_speed * 6;
intro_neurosys_start = intro_gm_end;
intro_neurosys_end = intro_neurosys_start + room_speed * 16;
intro_fade_out_start = intro_neurosys_end;
intro_fade_out_end = intro_fade_out_start + room_speed * 2;
intro_black_end = intro_fade_out_end + room_speed;
intro_duration = intro_black_end;

fade_time = room_speed * 2;
title_text = "NeuroSys";
subtitle_text = "Conecte empatia. Bloqueie o ódio.";
status_text = "sinais digitais detectados";

title_index = 0;
subtitle_index = 0;
status_index = 0;
typing_speed = 5;
type_pulse = 0;

scan_offset = 0;
glitch_timer = 0;
glitch_amount = 0;
line_width = 0;
transition_started = false;

global.intro_phase = -1;
global.intro_phase_alpha = 0;
