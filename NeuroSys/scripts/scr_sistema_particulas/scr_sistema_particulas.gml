// --- INICIALIZAÇÃO (Roda uma vez) ---
global.ps = part_system_create();
part_system_depth(global.ps, -1000);

global.pt_universal = part_type_create();

// Configurações base (que não mudam)
part_type_shape(global.pt_universal, pt_shape_disk); // Usei DISK para preencher melhor
part_type_speed(global.pt_universal, 2, 5, -0.1, 0);
part_type_direction(global.pt_universal, 0, 359, 0, 0);
part_type_life(global.pt_universal, 20, 40);
part_type_alpha3(global.pt_universal, 1, 0.8, 0);

// --- A FUNÇÃO COM ESCALA ---
/// @function criar_explosao(x, y, cor, quantidade, escala)
function criar_explosao_particulas(_x, _y, _cor, _qtd, _escala){
    
    // Define a escala (tamanho_min, tamanho_max, incremento, oscilação)
    // O incremento negativo (-0.05 * _escala) faz ela sumir proporcionalmente
    part_type_size(global.pt_universal, _escala, _escala * 1.5, -0.05 * _escala, 0);
    
    // Define a cor
    part_type_color1(global.pt_universal, _cor);
    
    // Cria as partículas
    part_particles_create(global.ps, _x, _y, global.pt_universal, min(_qtd, 24));
}
