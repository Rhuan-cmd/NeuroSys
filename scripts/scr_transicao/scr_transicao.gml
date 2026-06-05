function transicao(_room_destino) {
    // Se já houver uma transição acontecendo, não faz nada
    if (instance_exists(obj_transicao)) return;

    var _inst = instance_create_depth(0, 0, -10000, obj_transicao);
    _inst.proxima_room = _room_destino;
}

function audio_room_enter(_room_token) {
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
    if (global.audio_menu_musica == -1 || !audio_is_playing(global.audio_menu_musica)) {
        global.audio_menu_musica = audio_play_sound(snd_menu_musica, 0, true, 0);
    }
    audio_sound_gain(global.audio_menu_musica, _ganho, 700);
}

function audio_menu_fade(_ganho, _tempo) {
    if (variable_global_exists("audio_menu_musica") && global.audio_menu_musica != -1 && audio_is_playing(global.audio_menu_musica)) {
        audio_sound_gain(global.audio_menu_musica, _ganho, _tempo);
    }
}
