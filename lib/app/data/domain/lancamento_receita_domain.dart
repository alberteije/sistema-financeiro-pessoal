class LancamentoReceitaDomain {
	LancamentoReceitaDomain._();

	static getStatusReceita(String? statusReceita) { 
		switch (statusReceita) { 
			case '': 
			case 'R': 
				return 'Recebido'; 
			case 'A': 
				return 'A Receber'; 
			default: 
				return null; 
		} 
	} 

	static setStatusReceita(String? statusReceita) { 
		switch (statusReceita) { 
			case 'Recebido': 
				return 'R'; 
			case 'A Receber': 
				return 'A'; 
			default: 
				return null; 
		} 
	}

}