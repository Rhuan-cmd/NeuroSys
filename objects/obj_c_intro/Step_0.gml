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
    if (global.intro_phase >= 0 && global.intro_phase < 3) {
        audio_play_sound(snd_intro_transicao, 1, false);
    }
    intro_last_phase = global.intro_phase;
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
            audio_play_sound(snd_intro_digitacao, 2, false);
        } else if (subtitle_index < string_length(subtitle_text)) {
            subtitle_index += 1;
            type_pulse = 1;
            audio_play_sound(snd_intro_digitacao, 2, false);
        } else if (status_index < string_length(status_text)) {
            status_index += 1;
            type_pulse = 1;
            audio_play_sound(snd_intro_digitacao, 2, false);
        }
    }

    line_width = lerp(line_width, 440, 0.045);
}

if (!transition_started && intro_timer >= intro_duration) {
    transition_started = true;
    audio_sound_gain(intro_music_id, 0, 900);
    room_goto(rm_menu);
}

if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
    audio_sound_gain(intro_music_id, 0, 250);
    room_goto(rm_menu);
}
