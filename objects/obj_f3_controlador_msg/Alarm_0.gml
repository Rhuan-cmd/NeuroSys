var centro_x = obj_f3_npc.x;
var centro_y = obj_f3_npc.y;
var margem = 100;

// 1. Sorteia de onde ele vai vir (Seu código original)
var lado = irandom(3);
var spawn_x, spawn_y;
switch (lado) {
    case 0: spawn_x = random_range(-margem, room_width + margem); spawn_y = -margem; break;
    case 1: spawn_x = random_range(-margem, room_width + margem); spawn_y = room_height + margem; break;
    case 2: spawn_x = -margem; spawn_y = random_range(-margem, room_height + margem); break;
    case 3: spawn_x = room_width + margem; spawn_y = random_range(-margem, room_height + margem); break;
}

// 2. Calcula a distância e a velocidade que ESSE objeto terá
var dist_novo = point_distance(spawn_x, spawn_y, centro_x, centro_y);

// Damos uma leve variada na velocidade para não ficar robótico demais
var spd_novo = random_range(vel_atual * 0.9, vel_atual * 1.1); 

// Tempo = Distância / Velocidade. Isso dá os frames exatos que ele leva pra chegar.
var tempo_chegada_novo = dist_novo / spd_novo; 

// 3. Verifica se vai bater junto com algum objeto que JÁ EXISTE
var pode_spawnar = true;

with (obj_f3_msg_negativa) {
    var dist_existente = point_distance(x, y, centro_x, centro_y);
    
    // Assumindo que o objeto usa a variável nativa 'speed' para se mover.
    // Se você usa uma variável própria (ex: spd, vel), troque 'speed' por ela abaixo.
    var tempo_chegada_existente = dist_existente / speed;
    
    // Se a diferença de tempo de chegada entre eles for menor que a margem de segurança...
    if (abs(tempo_chegada_existente - tempo_chegada_novo) < other.margem_frames_chegada) {
        pode_spawnar = false;
        break; // Achou conflito, já pode parar de procurar
    }
}

// 4. Executa o Spawn ou entra na Fila
if (pode_spawnar) {
    var inst = instance_create_layer(spawn_x, spawn_y, layer, obj_f3_msg_negativa);
    
    // Já passamos a velocidade e direção para o objeto assim que ele nasce
    inst.speed = spd_novo;
    inst.direction = point_direction(spawn_x, spawn_y, centro_x, centro_y);
    
    // Reinicia o alarme usando a taxa atualizada pela dificuldade + um leve random
    alarm[0] = spawn_rate_atual + random_range(-10, 10);
} else {
    // Teve conflito de tempo no centro! Espera 5 frames e tenta sortear de novo.
    alarm[0] = 5;
}