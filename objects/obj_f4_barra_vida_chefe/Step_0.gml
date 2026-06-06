hp = clamp(hp, 0, 1);

progresso = lerp(progresso, tamanho_sprite * hp, 0.05);
offset = tamanho_sprite - progresso;

if (hp <= 0.75 && coracao1 == 0){
	coracao1 = 1;
	criar_explosao_particulas(position_x+tamanho_coracao*3+tamanho_coracao/2, position_y+altura_coracao/2, c_red, 10, 0.2);
	audio_play_sfx(snd_f4_impacto_chefe, 1, 0);
	tremer = true;
}

if (hp <= 0.5 && coracao2 == 0){
	coracao2 = 1;
	criar_explosao_particulas(position_x+tamanho_coracao*2+tamanho_coracao/2, position_y+altura_coracao/2, c_red, 10, 0.2);
	audio_play_sfx(snd_f4_impacto_chefe, 1, 0);
	tremer = true;
}

if (hp <= 0.25 && coracao3 == 0){
	coracao3 = 1;
	criar_explosao_particulas(position_x+tamanho_coracao+tamanho_coracao/2, position_y+altura_coracao/2, c_red, 10, 0.2);
	audio_play_sfx(snd_f4_impacto_chefe, 1, 0);
	tremer = true;
}

if (hp <= 0 && coracao4 == 0){
	coracao4 = 1;
	criar_explosao_particulas(position_x+tamanho_coracao/2, position_y+altura_coracao/2, c_red, 10, 0.2);
	audio_play_sfx(snd_f4_impacto_chefe, 1, 0);
	tremer = true;
}


if (tremer){
	var dt = delta_time / 1000000;
	tempo_tremer -= dt;
	
	position_x = base_x + irandom_range(-5, 5);
	position_y = base_y + irandom_range(-5, 5);
	
	if (tempo_tremer <= 0){
		tempo_tremer = 0.5;
		position_x = base_x;
		position_y = base_y;
		tremer = false;
	}
}