class Constants {
	Constants._();

	static const String appName =	'Sistema Financeiro Pessoal';
	static const String appVersion =	'version 1.0.1';
	
	static const double flutterBootstrapGutterSize = 10.0;
	static const int gridRowsPerPage = 10;

	static const String imageDir = 'assets/images';
	static const String dialogQuestionIcon = '$imageDir/dialog-question-icon.png';
	static const String dialogInfoIcon = '$imageDir/dialog-info-icon.png';
	static const String dialogErrorIcon = '$imageDir/dialog-error-icon.png';	
	static const String logotipo = '$imageDir/logotipo.png';
	static const String backgroundImage = '$imageDir/background.png';
	static const String loginImage = '$imageDir/login.jpg';
	static const String profileImage = '$imageDir/profile.png';

	// local database
	static const sqlGetSettings = "SELECT * FROM HIDDEN_SETTINGS WHERE ID=1";
}

enum DialogType {
	info,
	warning,
	error,
	success,
	question,
	noHeader
}