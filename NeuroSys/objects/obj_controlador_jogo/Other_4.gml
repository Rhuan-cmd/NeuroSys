// ===== ROOM START: MARCADOR AUTOMATICO POR SALA =====
// Ao iniciar uma room, o console indica qual cenário deve ser capturado pelo
// Profiler do Debugger (F6). Analise principalmente o primeiro pico: ele revela
// carregamentos, árvores de herança, loops grandes e filas de colisão.
global.perf_room = room_get_name(room);
global.perf_log_timer = 0;
global.perf_draw_log_timer = 0;
global.perf_frame_inicio = get_timer();
show_debug_message("[PERF] Room Start: " + global.perf_room);
show_debug_message("[PERF] No F6 > Profiler, grave os primeiros segundos desta room e ordene por tempo para encontrar gargalos.");
