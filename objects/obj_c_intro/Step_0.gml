window_set_cursor(cr_none);
cursor_sprite = cr_none;

intro_timer += 1;
scan_offset = (scan_offset + 1) mod 18;
type_pulse = max(0, type_pulse - 0.06);

if (intro_timer < intro_ifma_start) {
    global.intro_phase = -1;
    global.intro_phase_alpha = 0;
} else if (intro_timer < intro_ifma_end) {
    global.intro_phase = 0;
    var ifma_in = clamp((intro_timer - intro_ifma_start) / fade_time, 0, 1);
    var ifma_out = clamp((intro_ifma_end - intro_timer) / fade_time, 0, 1);
    global.intro_phase_alpha = min(ifma_in, ifma_out);
} else if (intro_timer < intro_gm_end) {
    global.intro_phase = 1;
    var gm_in = clamp((intro_timer - intro_gm_start) / fade_time, 0, 1);
    var gm_out = clamp((intro_gm_end - intro_timer) / fade_time, 0, 1);
    global.intro_phase_alpha = min(gm_in, gm_out);
} else if (!intro_video_finished) {
    global.intro_phase = 4;
    global.intro_phase_alpha = clamp((intro_timer - intro_video_start) / fade_time, 0, 1);
} else if (intro_timer < intro_neurosys_start) {
    global.intro_phase = 3;
    global.intro_phase_alpha = 0;
} else if (intro_timer < intro_fade_out_start) {
    global.intro_phase = 2;
    global.intro_phase_alpha = clamp((intro_timer - intro_neurosys_start) / fade_time, 0, 1);
} else if (intro_timer < intro_fade_out_end) {
    global.intro_phase = 2;
    global.intro_phase_alpha = 1;
} else {
    global.intro_phase = 3;
    global.intro_phase_alpha = 0;
}

if (global.intro_phase != intro_last_phase) {
    if ((global.intro_phase >= 0 && global.intro_phase < 3) || global.intro_phase == 4) {
        audio_play_sfx(snd_intro_transicao, 1, false, 1, 0, 1);
    }
    intro_last_phase = global.intro_phase;
}

if (global.intro_phase == 4) {
    if (!intro_video_started) {
        var _video_path = "datafiles/Aprenda.mp4";
        if (!file_exists(_video_path)) _video_path = "Aprenda.mp4";
        video_open(_video_path);
        video_set_volume(0.72);
        intro_video_started = true;
        intro_video_closed = false;
    }

    var _video_status = video_get_status();
    intro_video_ready = intro_video_ready || (_video_status == video_status_playing && intro_video_draw_status == 0);
    if (intro_video_ready && !intro_video_encerrando) {
        var _video_duracao = video_get_duration();
        if (_video_duracao > intro_video_fade_pre_ms) {
            intro_video_fade_alpha = max(
                intro_video_fade_alpha,
                clamp((video_get_position() - (_video_duracao - intro_video_fade_pre_ms)) / intro_video_fade_pre_ms, 0, 1)
            );
        }
    }
    if (intro_video_ready && !intro_video_encerrando) {
        intro_video_hint_timer += 1;
    }

    var _sem_surface_final = intro_video_ready && intro_video_sem_surface_timer >= round(room_speed * 0.6);
    if (intro_video_ready && !intro_video_encerrando && (intro_video_draw_status == -2 || _sem_surface_final)) {
        intro_video_encerrando = true;
        intro_video_fade_timer = 0;
    }

    intro_skip_flash = max(0, intro_skip_flash - 0.05);
    if (intro_video_ready && !intro_video_encerrando && keyboard_check_pressed(vk_enter)) {
        if (intro_timer - intro_enter_last <= round(room_speed * 0.42)) {
            intro_skip_flash = 1;
            intro_video_encerrando = true;
            intro_video_fade_timer = 0;
        }
        intro_enter_last = intro_timer;
    }

    if (intro_video_encerrando) {
        intro_video_fade_timer += 1;
        intro_video_fade_alpha = max(intro_video_fade_alpha, clamp(intro_video_fade_timer / max(1, room_speed * 0.45), 0, 1));
        if (intro_video_fade_timer >= round(room_speed * 0.45)) {
            intro_finalizar_video();
        }
    }
} else if (intro_video_finished && intro_video_started && !intro_video_closed) {
    video_close();
    intro_video_closed = true;
}

if (global.intro_phase == 2) {
    glitch_timer -= 1;

    if (glitch_timer <= 0) {
        glitch_timer = irandom_range(14, 34);
        glitch_amount = irandom_range(0, 3);
    } else {
        glitch_amount = max(0, glitch_amount - 1);
    }

    if (intro_timer mod typing_speed == 0) {
        if (title_index < string_length(title_text)) {
            title_index += 1;
            type_pulse = 1;
            audio_play_sfx(snd_intro_digitacao, 2, false, 1, 0, 1);
        } else if (subtitle_index < string_length(subtitle_text)) {
            subtitle_index += 1;
            type_pulse = 1;
            audio_play_sfx(snd_intro_digitacao, 2, false, 1, 0, 1);
        } else if (status_index < string_length(status_text)) {
            status_index += 1;
            type_pulse = 1;
            audio_play_sfx(snd_intro_digitacao, 2, false, 1, 0, 1);
        }
    }

    line_width = lerp(line_width, 440, 0.045);
}

if (!transition_started && intro_video_finished && intro_timer >= intro_duration) {
    transition_started = true;
    audio_gain_music(intro_music_id, 0, 900);
    if (intro_video_started && !intro_video_closed) video_close();
    room_goto(rm_menu);
}

if (keyboard_check_pressed(vk_space)) {
    audio_gain_music(intro_music_id, 0, 250);
    if (intro_video_started && !intro_video_closed) video_close();
    room_goto(rm_menu);
}
