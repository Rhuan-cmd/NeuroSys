if (view_camera[0] != -1) {
    camera_set_view_pos(view_camera[0], view_base_x, view_base_y);
}
cursor_sprite = spr_mouse;
audio_stop_sound(snd_f2_ambiente);
audio_stop_sound(snd_f2_ambiente_corrupto);
audio_stop_sound(snd_f2_chiado);
audio_stop_sound(snd_f2_tremor_loop);
audio_stop_sound(snd_f2_sino);
