gpu_set_texfilter(false);
audio_room_enter("intro");
window_set_cursor(cr_none);
cursor_sprite = cr_none;
display_set_gui_size(960, 540);
if (!variable_global_exists("fx_surface_w")) global.fx_surface_w = 960;
if (!variable_global_exists("fx_surface_h")) global.fx_surface_h = 540;
if (surface_exists(application_surface)) {
    surface_resize(application_surface, global.fx_surface_w, global.fx_surface_h);
}

intro_timer = 0;

intro_black_start = room_speed;
intro_ifma_start = intro_black_start;
intro_ifma_end = intro_ifma_start + room_speed * 5;
intro_gm_start = intro_ifma_end;
intro_gm_end = intro_gm_start + room_speed * 5;
intro_video_start = intro_gm_end;
intro_video_end = intro_video_start;
intro_neurosys_start = intro_video_start;
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
intro_music_id = ns_audio_play_music(snd_intro_apresentacao, 0, true, 1, 0, 1);
ns_audio_gain_music(intro_music_id, 0.62, 0);
intro_video_started = false;
intro_video_closed = false;
intro_video_finished = false;
intro_video_ready = false;
intro_video_draw_status = -1;
intro_video_hint_timer = 0;
intro_video_encerrando = false;
intro_video_fade_timer = 0;
intro_video_sem_surface_timer = 0;
intro_video_fade_alpha = 0;
intro_video_fade_pre_ms = 1800;
intro_enter_last = -999;
intro_skip_flash = 0;

intro_finalizar_video = function() {
    if (intro_video_started && !intro_video_closed) {
        video_close();
        intro_video_closed = true;
    }

    intro_video_finished = true;
    intro_video_end = intro_timer;
    intro_neurosys_start = intro_timer + round(room_speed * 0.55);
    intro_neurosys_end = intro_neurosys_start + room_speed * 8;
    intro_fade_out_start = intro_neurosys_end;
    intro_fade_out_end = intro_fade_out_start + round(room_speed * 2.5);
    intro_black_end = intro_fade_out_end + round(room_speed * 1.4);
    intro_duration = intro_black_end;
    title_index = 0;
    subtitle_index = 0;
    status_index = 0;
    line_width = 0;
    glitch_timer = 0;
    glitch_amount = 0;
};

global.intro_phase = -1;
global.intro_phase_alpha = 0;
