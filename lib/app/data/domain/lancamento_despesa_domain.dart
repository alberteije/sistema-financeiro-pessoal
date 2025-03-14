class LancamentoDespesaDomain {
	LancamentoDespesaDomain._();

	static getStatusDespesa(String? statusDespesa) { 
		switch (statusDespesa) { 
			case '': 
			case 'P': 
				return 'Pago'; 
			case 'A': 
				return 'A Pagar'; 
			case 'V': 
				return 'Vencido'; 
			default: 
				return null; 
		} 
	} 

	static setStatusDespesa(String? statusDespesa) { 
		switch (statusDespesa) { 
			case 'Pago': 
				return 'P'; 
			case 'A Pagar': 
				return 'A'; 
			case 'Vencido': 
				return 'V'; 
			default: 
				return null; 
		} 
	}

}