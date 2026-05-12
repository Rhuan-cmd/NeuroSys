// Avança o timer
timer += velocidade;

if (estado == "indo") {
    // Se a animação "indo" terminou
    if (timer >= tempo_maximo) {
        timer = 0; // Reseta o timer para a próxima fase
        estado = "voltando";
        room_goto(proxima_room); // Muda de sala
        audio_stop_all();
    }
} else if (estado == "voltando") {
    // Se a animação "voltando" terminou
    if (timer >= tempo_maximo) {
        instance_destroy(); // Destrói o objeto, fim da transição
    }
}