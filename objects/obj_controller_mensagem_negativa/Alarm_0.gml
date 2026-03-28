// 1. Defina a distância (margem) fora da tela para o objeto não "piscar" na borda
var margem = 100; 

// 2. Sorteia um lado: 0 = Topo, 1 = Baixo, 2 = Esquerda, 3 = Direita
var lado = irandom(3);

var spawn_x, spawn_y;

switch (lado) {
    case 0: // TOPO
        spawn_x = random_range(-margem, room_width + margem);
        spawn_y = -margem;
        break;
        
    case 1: // BAIXO
        spawn_x = random_range(-margem, room_width + margem);
        spawn_y = room_height + margem;
        break;
        
    case 2: // ESQUERDA
        spawn_x = -margem;
        spawn_y = random_range(-margem, room_height + margem);
        break;
        
    case 3: // DIREITA
        spawn_x = room_width + margem;
        spawn_y = random_range(-margem, room_height + margem);
        break;
}

// 3. Cria o objeto na posição sorteada
instance_create_layer(spawn_x, spawn_y, layer, obj_mensagem_negativa);
alarm[0] = irandom_range(60, 90);