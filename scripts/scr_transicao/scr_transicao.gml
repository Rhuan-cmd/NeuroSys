function transicao(_room_destino) {
    // Se já houver uma transição acontecendo, não faz nada
    if (instance_exists(obj_transicao)) return;
    if (variable_global_exists("fx_cortar_transicoes") && global.fx_cortar_transicoes) {
        global.transicao_ativa = false;
        room_goto(_room_destino);
        return;
    }

    var _inst = instance_create_depth(0, 0, -10000, obj_transicao);
    _inst.proxima_room = _room_destino;
}

function ns_audio_volume_musica() {
    if (!variable_global_exists("op_volume_musica")) global.op_volume_musica = 1;
    return clamp(global.op_volume_musica, 0, 1);
}

function ns_audio_volume_efeitos() {
    if (!variable_global_exists("op_volume_efeitos")) global.op_volume_efeitos = 1;
    return clamp(global.op_volume_efeitos, 0, 1);
}

function ns_audio_play_music(_sound, _priority, _loop, _gain, _offset, _pitch) {
    var _volume = ns_audio_volume_musica();
    if (_volume <= 0) return -1;
    return audio_play_sound(_sound, _priority, _loop, _gain * _volume, _offset, _pitch);
}

function ns_audio_play_sfx(_sound, _priority, _loop, _gain, _offset, _pitch) {
    var _volume = ns_audio_volume_efeitos();
    if (_volume <= 0) return -1;
    return audio_play_sound(_sound, _priority, _loop, _gain * _volume, _offset, _pitch);
}

function ns_audio_gain_music(_audio, _gain, _time) {
    if (_audio == -1) return;
    audio_sound_gain(_audio, _gain * ns_audio_volume_musica(), _time);
}

function ns_audio_gain_sfx(_audio, _gain, _time) {
    if (_audio == -1) return;
    audio_sound_gain(_audio, _gain * ns_audio_volume_efeitos(), _time);
}

function ns_audio_aplicar_opcoes() {
    if (!variable_global_exists("op_volume")) global.op_volume = 1;
    if (!variable_global_exists("op_volume_musica")) global.op_volume_musica = 1;
    if (!variable_global_exists("op_volume_efeitos")) global.op_volume_efeitos = 1;
    if (global.op_volume_musica <= 0 && global.op_volume_efeitos <= 0) {
        global.op_volume = 0;
    }
    audio_master_gain(clamp(global.op_volume, 0, 1));
}

function audio_room_enter(_room_token) {
    if (_room_token == "menu" || _room_token == "menu_fases") {
        audio_stop_sound(snd_creditos_musica);
    }

    if (variable_global_exists("audio_preservar_limpeza") && global.audio_preservar_limpeza) {
        global.audio_preservar_limpeza = false;
        global.audio_room_token = _room_token;
        return;
    }

    audio_stop_all();
    global.audio_menu_musica = -1;
    global.audio_room_token = _room_token;
}

function audio_menu_iniciar(_ganho) {
    if (!variable_global_exists("audio_menu_musica")) global.audio_menu_musica = -1;
    if (!variable_global_exists("op_volume_musica")) global.op_volume_musica = 1;
    if (global.audio_menu_musica == -1 || !audio_is_playing(global.audio_menu_musica)) {
        global.audio_menu_musica = ns_audio_play_music(snd_menu_musica, 0, true, 0, 0, 1);
    }
    ns_audio_gain_music(global.audio_menu_musica, _ganho, 700);
}

function audio_menu_fade(_ganho, _tempo) {
    if (!variable_global_exists("op_volume_musica")) global.op_volume_musica = 1;
    if (variable_global_exists("audio_menu_musica") && global.audio_menu_musica != -1 && audio_is_playing(global.audio_menu_musica)) {
        ns_audio_gain_music(global.audio_menu_musica, _ganho, _tempo);
    }
}

function ns_video_aplicar(_idx, _fullscreen) {
    var _res_w = [960, 1280, 1600, 1920];
    var _res_h = [540, 720, 900, 1080];
    var _i = clamp(_idx, 0, 3);
    var _w = _res_w[_i];
    var _h = _res_h[_i];

    if (_fullscreen) {
        window_set_size(_w, _h);
        window_center();
        window_set_fullscreen(true);
    } else {
        window_set_fullscreen(false);
        var _max_w = max(640, display_get_width() - 80);
        var _max_h = max(360, display_get_height() - 120);
        var _scale = min(1, min(_max_w / _w, _max_h / _h));
        window_set_size(floor(_w * _scale), floor(_h * _scale));
        window_center();
    }

    display_set_gui_size(960, 540);
    if (surface_exists(application_surface)) {
        surface_resize(application_surface, variable_global_exists("fx_surface_w") ? global.fx_surface_w : 960, variable_global_exists("fx_surface_h") ? global.fx_surface_h : 540);
    }
}
