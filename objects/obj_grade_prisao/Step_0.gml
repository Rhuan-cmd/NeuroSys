// Animação de entrada
if (estado == "abrindo") {
    abertura = lerp(abertura, 1, 0.08);
    if (abertura > 0.99) { abertura = 1; estado = "ativo"; }
}

timer_ruido++;
timer_sirene += velocidade_sirene;