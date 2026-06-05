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
    global.audio_room_token = _room_token;
}
