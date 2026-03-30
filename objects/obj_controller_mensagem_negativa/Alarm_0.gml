// 1. Verificar se a última mensagem já se afastou o suficiente do ponto de spawn
var pode_spawnar = true;

if (instance_exists(ultima_mensagem)) {
    // Se a distância entre o centro e a última mensagem for muito grande, 
    // significa que ela ainda está perto da borda de onde nasceu.
    var dist = point_distance(ultima_mensagem.x, ultima_mensagem.y, room_width/2, room_height/2);
    
    // Se a distância for maior que o "raio de segurança", ela ainda está chegando.
    // Precisamos que ela esteja MAIS PERTO do centro para soltar a próxima.
    // Ajuste o valor 400 para o tamanho do seu "raio de spawn"
    if (dist > 350) { 
        pode_spawnar = false;
    }
}

if (pode_spawnar) {
    // --- SEU CÓDIGO DE SORTEIO DE LADO (MANTÉM IGUAL) ---
    var margem = 100;
    var lado = irandom(3);
    var spawn_x, spawn_y;
    switch (lado) {
        case 0: spawn_x = random_range(-margem, room_width + margem); spawn_y = -margem; break;
        case 1: spawn_x = random_range(-margem, room_width + margem); spawn_y = room_height + margem; break;
        case 2: spawn_x = -margem; spawn_y = random_range(-margem, room_height + margem); break;
        case 3: spawn_x = room_width + margem; spawn_y = random_range(-margem, room_height + margem); break;
    }

    // 2. Criar e salvar como a "última"
    ultima_mensagem = instance_create_layer(spawn_x, spawn_y, layer, obj_mensagem_negativa);
    
    // 3. Reinicia o alarme normalmente
    alarm[0] = irandom_range(40, 80); 
} else {
    // Se não pode spawnar agora, tenta de novo daqui a 5 frames (muito rápido)
    // Isso cria a "fila" que você deseja
    alarm[0] = 5; 
}