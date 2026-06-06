if (aparecer && global.intro_phase == 1) {
    gm_timer += 1;

    if (gm_timer mod gm_text_vel == 0 && gm_text_index < string_length(gm_text)) {
        gm_text_index += 1;
        ns_audio_play_sfx(snd_intro_digitacao, 2, false, 0.72, 0, 1);
    }

    gm_logo_alpha = lerp(gm_logo_alpha, global.intro_phase_alpha, 0.08);
}
