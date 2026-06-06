// --- DADOS DA GRADE ---
largura_grade = 150;   
altura_grade = 100;    
espacamento = 15;      // Espaço entre as barras verticais
espessura_barra = 5;  // BARRAS BEM GROSSAS

// --- CORES E GLITCH ---
cor_base = make_color_rgb(0, 255, 255); 
intensidade_glitch = 3;

// --- ANIMAÇÃO ---
abertura = 0; 
estado = "abrindo";
timer_ruido = 0;

sirene_audio = audio_play_sfx(snd_f4_sirene, 1, true, 0.5, 0, 1);
audio_gain_sfx(sirene_audio, 0, 5200);

// --- SIRENE E CADEADO ---
timer_sirene = 0;
velocidade_sirene = 0.2;
cor_policia_1 = c_red;
cor_policia_2 = c_blue;
