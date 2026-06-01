// --- Evento Create ---
textos = ["Nem sei por que você continua tentando... ninguém se importa.", "Você acha que pode me parar?", "Pode denunciar, bloquear... sempre vai aparecer outro igual a mim.", "Então vai lá... faz alguma coisa. Quero ver até onde você aguenta."];
pagina_atual = 0;
tamanho_texto = 0;
velocidade_texto = 0.5;

sprite_rosto = spr_f4_vilao;
abertura = 0; 
estado = "";

// Variáveis de borda
pontos_borda = 20; 
offsets_borda = array_create(pontos_borda, 0); 
intensidade_glitch = 4; // REDUZIDO: Antes era livre, agora limitamos a 4 pixels

alarm[0] = 120;
