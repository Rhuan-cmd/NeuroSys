gpu_set_texfilter(false);
audio_room_enter("intro");
window_set_cursor(cr_none);
cursor_sprite = cr_none;
display_set_gui_size(960, 540);
if (surface_exists(application_surface)) {
    surface_resize(application_surface, 960, 540);
}

intro_timer = 0;

intro_black_start = room_speed;
intro_ifma_start = intro_black_start;
intro_ifma_end = intro_ifma_start + room_speed * 5;
intro_gm_start = intro_ifma_end;
intro_gm_end = intro_gm_start + room_speed * 5;
intro_video_start = intro_gm_end;
intro_video_end = intro_video_start + room_speed * 9;
intro_neurosys_start = intro_video_end;
intro_neurosys_end = intro_neurosys_start + room_speed * 8;
intro_fade_out_start = intro_neurosys_end;
intro_fade_out_end = intro_fade_out_start + round(room_speed * 2.5);
intro_black_end = intro_fade_out_end + round(room_speed * 1.4);
intro_duration = intro_black_end;

fade_time = room_speed;

title_text = "NeuroSys";
subtitle_text = "Conecte empatia. Bloqueie o ódio.";
status_text = "sinais digitais detectados";

title_index = 0;
subtitle_index = 0;
status_index = 0;
typing_speed = 4;
type_pulse = 0;

scan_offset = 0;
glitch_timer = 0;
glitch_amount = 0;
line_width = 0;
transition_started = false;
intro_last_phase = -2;
intro_music_id = audio_play_sound(snd_intro_apresentacao, 0, true);
audio_sound_gain(intro_music_id, 0.62, 0);
intro_video_started = false;
intro_video_closed = false;
intro_enter_last = -999;
intro_skip_flash = 0;

global.intro_phase = -1;
global.intro_phase_alpha = 0;
