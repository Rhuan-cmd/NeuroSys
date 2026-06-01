if (gerar_dislike){
	timer_geracao--;

	if (timer_geracao <= 0) {
	    // Define um Y aleatório dentro da altura de 100 pixels da área
	    var spawn_y = irandom_range(pos_y, pos_y + 100);
        
	    // Instancia o objeto no canto esquerdo (x = -50 para ele entrar na tela)
	    instance_create_layer(-50, spawn_y, layer, obj_f4_descurtida);
        
	    // Reseta o timer para o próximo objeto
	    timer_geracao = delay_entre_objetos;
	}
}