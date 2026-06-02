randomise();

matriz = [
	[0, 0, 0, 0],
	[0, 0, 0, 0]
];


function retornar_sorteaveis(){
	var sorteaveis = ds_list_create();
	for (var i = 0; i < 2; i++){
		for (var e = 0; e < 4; e++){
			var celula = matriz[i][e];
			
			if (celula == 0){
				var item = string(i) + "_" + string(e);
				ds_list_add(sorteaveis, item);
			}
		}
	}
	
	return sorteaveis;
}

function sortear_celula(){
	var array = retornar_sorteaveis();
	
	if (ds_list_size(array) <= 0){
		ds_list_destroy(array);
		for (var i = 0; i < 2; i++){
			for (var e = 0; e < 4; e++){
				matriz[i][e] = 0;
			}
		}
		array = retornar_sorteaveis();
	}
	
	
	var itemSorteado = irandom_range(0, ds_list_size(array)-1);
	
	
	var itensArray = string_split(ds_list_find_value(array, itemSorteado), "_");
	
	var linha = real(itensArray[0]);
	var coluna = real(itensArray[1]);
	
	var resultado = {
		linha: linha,
		coluna: coluna
	};
	ds_list_destroy(array);
	return resultado;
}

function spawnar_ataque(){
	var celula = sortear_celula();
	
	if (!celula) return;
	
	var linha = celula.linha;
	var coluna = celula.coluna;
	
	matriz[linha][coluna] = 1;
	
	var _x = ((room_width/4) * coluna) + (room_width/4)/2;
	var _y = (room_height/2) + ((room_height/4) * linha) + (room_height/4)/2;
	
	
	var obj = instance_create_layer(_x, _y, layer, obj_f4_silhueta);
	
	obj.linha = linha;
	obj.coluna = coluna;
}

alarm[0] = 60;
