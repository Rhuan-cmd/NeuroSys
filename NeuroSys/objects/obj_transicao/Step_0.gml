timer += velocidade;

if (estado == "indo") {
    if (timer >= 1) {
        timer = 0;
        estado = "voltando";
        room_goto(proxima_room);
        audio_stop_all();
    }
} else if (estado == "voltando") {
    if (timer >= 1) {
        instance_destroy();
    }
}
