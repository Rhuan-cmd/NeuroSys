timer += 1;

if (timer >= duracao) {
    if (reverso) {
        global.menu_reverso = false;
        global.audio_preservar_limpeza = true;
    }
    room_goto(proxima_room);
}
