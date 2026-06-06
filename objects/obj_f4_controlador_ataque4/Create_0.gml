randomise();

matriz = [
	[0, 0, 0, 0],
	[0, 0, 0, 0]
];


function retornar_sorteaveis(){
	var sorteaveis = [];
	for (var i = 0; i < 2; i++){
		for (var e = 0; e < 4; e++){
			var celula = matriz[i][e];
			
			if (celula == 0){
				array_push(sorteaveis, [i, e]);
			}
		}
	}
	
	return sorteaveis;
}

function sortear_celula(){
	var array = retornar_sorteaveis();
	
	if (array_length(array) <= 0){
		for (var i = 0; i < 2; i++){
			for (var e = 0; e < 4; e++){
				matriz[i][e] = 0;
			}
		}
		array = retornar_sorteaveis();
	}
	
	
	var itemSorteado = irandom_range(0, array_length(array)-1);
	var itensArray = array[itemSorteado];
	var linha = itensArray[0];
	var coluna = itensArray[1];
	
	var resultado = {
		linha: linha,
		coluna: coluna
	};
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
