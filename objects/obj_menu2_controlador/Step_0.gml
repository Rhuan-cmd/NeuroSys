timer += 1;

if (timer >= duracao) {
    if (reverso) {
        global.menu_reverso = false;
    }
    room_goto(proxima_room);
}
