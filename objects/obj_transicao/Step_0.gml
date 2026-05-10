// Avança o timer
timer += velocidade;

if (estado == "indo") {
    // Se a animação "indo" terminou (timer > 1 + atraso máximo)
    if (timer >= 1 + (colunas + linhas) * atraso_diagonal * 0.1) {
        timer = 0; // Reseta o timer para a próxima fase
        estado = "voltando";
        room_goto(proxima_room); // Muda de sala
		audio_stop_all();
    }
} else if (estado == "voltando") {
    // Se a animação "voltando" terminou
    if (timer >= 1 + (colunas + linhas) * atraso_diagonal * 0.1) {
        instance_destroy(); // Destrói o objeto, fim da transição
    }
}