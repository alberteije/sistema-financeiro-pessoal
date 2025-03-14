class ResumoDomain {
	ResumoDomain._();

	static getReceitaDespesa(String? receitaDespesa) { 
		switch (receitaDespesa) { 
			case '': 
			case 'R': 
				return 'Receita'; 
			case 'D': 
				return 'Despesa'; 
			default: 
				return null; 
		} 
	} 

	static setReceitaDespesa(String? receitaDespesa) { 
		switch (receitaDespesa) { 
			case 'Receita': 
				return 'R'; 
			case 'Despesa': 
				return 'D'; 
			default: 
				return null; 
		} 
	}

}