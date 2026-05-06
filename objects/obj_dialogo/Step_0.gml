// --- Evento Step ---

// 1. Lógica de Animação de Entrada e Saída
if (estado == "abrindo") {
    abertura = lerp(abertura, 1, 0.1);
    if (abertura > 0.99) estado = "ativo";
} else if (estado == "fechando") {
    abertura = lerp(abertura, 0, 0.2);
    if (abertura < 0.05) instance_destroy();
}

// 2. Lógica de Texto (Máquina de escrever)
if (estado == "ativo") {
    if (tamanho_texto < string_length(textos[pagina_atual])) {
        tamanho_texto += velocidade_texto;
    }
    
    // Avançar diálogo
    if (keyboard_check_pressed(vk_space)) {
        if (tamanho_texto < string_length(textos[pagina_atual])) {
            tamanho_texto = string_length(textos[pagina_atual]);
        } else {
            pagina_atual++;
            tamanho_texto = 0;
            if (pagina_atual >= array_length(textos)) estado = "fechando";
        }
    }
}

// ... (mantenha a lógica de animação e texto igual) ...

// 3. Atualizar as Bordas Irregulares (Movimento mais sutil)
for (var i = 0; i < pontos_borda; i++) {
    // Usamos um valor menor para o tremor ser menos agressivo
    offsets_borda[i] = random_range(-intensidade_glitch, intensidade_glitch); 
}