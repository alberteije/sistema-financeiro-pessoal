class ExtratoBancarioDomain {
	ExtratoBancarioDomain._();

	static getConciliado(String? conciliado) { 
		switch (conciliado) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setConciliado(String? conciliado) { 
		switch (conciliado) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}