if (room == rm_fase4){
	cursor_sprite = cr_none;
}else{
	cursor_sprite = spr_ui_cursor;
}
window_set_cursor(cr_none);
gpu_set_texfilter(false);

// ===== MONITOR GLOBAL DE PERFORMANCE =====
// O overlay nativo separa visualmente o custo de CPU (Step) e GPU (Draw).
// Use F6 no GameMaker para abrir o Debugger e capturar o Profiler da room atual.
show_debug_overlay(false);

global.perf_room = room_get_name(room);
global.perf_overlay_ativo = false;
global.perf_limite_step_us = 2000;
global.perf_limite_draw_us = 4000;
global.perf_limite_frame_us = 16667;
global.perf_log_intervalo = room_speed * 2;
global.perf_log_timer = 0;
global.perf_draw_log_timer = 0;
global.perf_frame_inicio = get_timer();
global.perf_step_us = 0;
global.perf_draw_us = 0;
global.perf_frame_us = 0;
global.perf_fps = 60;

// Use estas funções ao redor de um loop suspeito para medir apenas aquele trecho.
// Exemplo:
// var _inicio = global.perf_iniciar_bloco();
// <fila de colisões, IA ou movimento procedural>
// global.perf_finalizar_bloco("fila de mensagens", _inicio);
global.perf_iniciar_bloco = function() {
    return get_timer();
};

global.perf_finalizar_bloco = function(_nome, _inicio) {
    var _tempo_us = get_timer() - _inicio;
    if (_tempo_us > global.perf_limite_step_us && global.perf_log_timer <= 0) {
        show_debug_message("[PERF][BLOCO] " + room_get_name(room) + " | " + _nome + ": " + string(_tempo_us) + " us. Reduza loops, remova instâncias órfãs e destrua surfaces temporárias.");
    }
    return _tempo_us;
};

show_debug_message("[PERF] Room carregada: " + global.perf_room);
show_debug_message("[PERF] Use F6 > Profiler nesta room. Capture o início para localizar loops, heranças, colisões e carregamentos pesados.");
show_debug_message("[PERF] F10 alterna o Debug Overlay para comparar o custo do diagnóstico.");
