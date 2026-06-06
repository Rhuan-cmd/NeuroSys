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

function audio_volume_musica() {
    if (!variable_global_exists("op_volume_musica")) global.op_volume_musica = 1;
    return clamp(global.op_volume_musica, 0, 1);
}

function audio_volume_efeitos() {
    if (!variable_global_exists("op_volume_efeitos")) global.op_volume_efeitos = 1;
    return clamp(global.op_volume_efeitos, 0, 1);
}

function audio_play_music() {
    var _sound = argument[0];
    var _priority = argument[1];
    var _loop = argument[2];
    var _gain = argument_count > 3 ? argument[3] : 1;
    var _offset = argument_count > 4 ? argument[4] : 0;
    var _pitch = argument_count > 5 ? argument[5] : 1;
    var _volume = audio_volume_musica();
    if (_volume <= 0) return -1;
    return audio_play_sound(_sound, _priority, _loop, _gain * _volume, _offset, _pitch);
}

function audio_play_sfx() {
    var _sound = argument[0];
    var _priority = argument[1];
    var _loop = argument[2];
    var _gain = argument_count > 3 ? argument[3] : 1;
    var _offset = argument_count > 4 ? argument[4] : 0;
    var _pitch = argument_count > 5 ? argument[5] : 1;
    var _volume = audio_volume_efeitos();
    if (_volume <= 0) return -1;
    return audio_play_sound(_sound, _priority, _loop, _gain * _volume, _offset, _pitch);
}

function audio_gain_music(_audio, _gain, _time) {
    if (_audio == -1) return;
    audio_sound_gain(_audio, _gain * audio_volume_musica(), _time);
}

function audio_gain_sfx(_audio, _gain, _time) {
    if (_audio == -1) return;
    audio_sound_gain(_audio, _gain * audio_volume_efeitos(), _time);
}

function audio_aplicar_opcoes() {
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
        global.audio_menu_musica = audio_play_music(snd_menu_musica, 0, true, 0);
    }
    audio_gain_music(global.audio_menu_musica, _ganho, 700);
}

function audio_menu_fade(_ganho, _tempo) {
    if (!variable_global_exists("op_volume_musica")) global.op_volume_musica = 1;
    if (variable_global_exists("audio_menu_musica") && global.audio_menu_musica != -1 && audio_is_playing(global.audio_menu_musica)) {
        audio_gain_music(global.audio_menu_musica, _ganho, _tempo);
    }
}
