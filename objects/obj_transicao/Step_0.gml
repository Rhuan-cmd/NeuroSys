timer += velocidade;
global.transicao_ativa = true;
window_set_cursor(cr_none);
cursor_sprite = cr_none;

if (estado == "indo") {
    if (timer >= 1) {
        timer = 0;
        estado = "voltando";
        audio_stop_all();
        room_goto(proxima_room);
    }
} else if (estado == "voltando") {
    if (timer >= 1) {
        global.transicao_ativa = false;
        instance_destroy();
    }
}
