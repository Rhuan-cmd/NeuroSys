function transicao(_room_destino) {
    // Se já houver uma transição acontecendo, não faz nada
    if (instance_exists(obj_transicao)) return;

    var _inst = instance_create_depth(0, 0, -10000, obj_transicao);
    _inst.proxima_room = _room_destino;
}