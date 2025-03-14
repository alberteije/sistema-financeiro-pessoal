import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/routes/app_routes.dart';
import 'package:financeiro_pessoal/app/page/login/login_page.dart';
import 'package:financeiro_pessoal/app/page/shared_page/splash_screen_page.dart';
import 'package:financeiro_pessoal/app/bindings/bindings_imports.dart';
import 'package:financeiro_pessoal/app/page/shared_page/shared_page_imports.dart';
import 'package:financeiro_pessoal/app/page/page_imports.dart';

class AppPages {
	
	static final pages = [
		GetPage(name: Routes.splashPage, page:()=> const SplashScreenPage()),
		GetPage(name: Routes.loginPage, page:()=> const LoginPage(), binding: LoginBindings()),
		GetPage(name: Routes.homePage, page:()=> HomePage()),
		GetPage(name: Routes.filterPage, page:()=> const FilterPage()),
		GetPage(name: Routes.lookupPage, page:()=> const LookupPage()),
		
		GetPage(name: Routes.contaDespesaListPage, page:()=> const ContaDespesaListPage(), binding: ContaDespesaBindings()), 
		GetPage(name: Routes.contaDespesaEditPage, page:()=> ContaDespesaEditPage()),
		GetPage(name: Routes.lancamentoDespesaListPage, page:()=> const LancamentoDespesaListPage(), binding: LancamentoDespesaBindings()), 
		GetPage(name: Routes.lancamentoDespesaEditPage, page:()=> LancamentoDespesaEditPage()),
		GetPage(name: Routes.resumoListPage, page:()=> const ResumoListPage(), binding: ResumoBindings()), 
		GetPage(name: Routes.resumoEditPage, page:()=> ResumoEditPage()),
		GetPage(name: Routes.extratoBancarioListPage, page:()=> const ExtratoBancarioListPage(), binding: ExtratoBancarioBindings()), 
		GetPage(name: Routes.extratoBancarioEditPage, page:()=> ExtratoBancarioEditPage()),
		GetPage(name: Routes.metodoPagamentoListPage, page:()=> const MetodoPagamentoListPage(), binding: MetodoPagamentoBindings()), 
		GetPage(name: Routes.metodoPagamentoEditPage, page:()=> MetodoPagamentoEditPage()),
		GetPage(name: Routes.contaReceitaListPage, page:()=> const ContaReceitaListPage(), binding: ContaReceitaBindings()), 
		GetPage(name: Routes.contaReceitaEditPage, page:()=> ContaReceitaEditPage()),
		GetPage(name: Routes.lancamentoReceitaListPage, page:()=> const LancamentoReceitaListPage(), binding: LancamentoReceitaBindings()), 
		GetPage(name: Routes.lancamentoReceitaEditPage, page:()=> LancamentoReceitaEditPage()),
		GetPage(name: Routes.usuarioListPage, page:()=> const UsuarioListPage(), binding: UsuarioBindings()), 
		GetPage(name: Routes.usuarioEditPage, page:()=> UsuarioEditPage()),
	];
}