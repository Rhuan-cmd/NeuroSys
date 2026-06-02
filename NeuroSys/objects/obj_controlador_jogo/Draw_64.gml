// ===== DIAGNOSTICO LEVE DE DRAW E GPU =====
// get_timer() mede o custo do bloco de diagnóstico. O overlay nativo mostra o
// custo completo de Draw/GPU; use o Profiler F6 para abrir o detalhe da room.
var _perf_draw_inicio = get_timer();
global.perf_draw_log_timer--;

if (surface_exists(application_surface)) {
    var _perf_surface_w = surface_get_width(application_surface);
    var _perf_surface_h = surface_get_height(application_surface);
    if ((_perf_surface_w > 960 || _perf_surface_h > 540) && global.perf_draw_log_timer <= 0) {
        show_debug_message("[PERF][GPU] Surface acima de 960x540 em " + room_get_name(room) + ". Reduza surfaces fullscreen e efeitos acumulados.");
        global.perf_draw_log_timer = global.perf_log_intervalo;
    }
}

global.perf_draw_us = get_timer() - _perf_draw_inicio;
if (global.perf_draw_us > global.perf_limite_draw_us && global.perf_draw_log_timer <= 0) {
    show_debug_message("[PERF][GPU] " + room_get_name(room) + " bloco Draw monitorado: " + string(global.perf_draw_us) + " us. Revise surfaces, partículas e camadas fullscreen.");
    global.perf_draw_log_timer = global.perf_log_intervalo;
}
