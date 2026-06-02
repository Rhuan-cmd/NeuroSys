randomise();

// --- VARIÁVEIS DE DIFICULDADE ---
nivel_dificuldade = 0; // Vai aumentar com o tempo no Step

// Taxa de Spawn (Tempo entre criações)
spawn_rate_base = 80;
spawn_rate_min = 25; // O mais rápido que o jogo vai conseguir spawnar

// Velocidade dos objetos
vel_base = 4;
vel_max = 10; // Velocidade máxima permitida

// --- VARIÁVEIS DE CONTROLE ---
// Quantos frames de "respiro" o jogador tem entre uma mensagem e outra chegando no centro
margem_frames_chegada = 20; 

alarm[0] = spawn_rate_base;