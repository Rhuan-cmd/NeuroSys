// Aumenta a dificuldade constantemente (aprox 1 nível a cada segundo a 60fps)
nivel_dificuldade += 1/60;

// Calcula o Spawn Rate atual (diminui com o tempo até o limite mínimo)
spawn_rate_atual = max(spawn_rate_min, spawn_rate_base - (nivel_dificuldade * 0.5));

// Calcula a Velocidade atual (aumenta com o tempo até o limite máximo)
vel_atual = min(vel_max, vel_base + (nivel_dificuldade * 0.05));