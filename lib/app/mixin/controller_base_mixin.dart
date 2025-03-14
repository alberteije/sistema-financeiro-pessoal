import 'package:financeiro_pessoal/app/infra/session.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/message_dialog.dart';

mixin ControllerBaseMixin {
  bool canInsert = false;
  bool canUpdate = false;
  bool canDelete = false;
  String functionName = "";

  void noPrivilegeMessage() {
    showNoPrivilegeSnackBar();
  }

  void setPrivilege() {
		/// You can create a table with all functions of the system and their access.
		/// The table would have the following fields:
		/// - functionName (funcaoNome in portuguese) = 'CUSTOMER' or 'VENDOR' - it should persist the name of the table
		/// - canInsert (podeInserir in portuguese) = it should persist 'Y' or 'N' ('Yes' in portuguese is 'Sim')
		/// - canUpdate (podeAlterar in portuguese) = it should persist 'Y' or 'N' ('Yes' in portuguese is 'Sim')
		/// - canDelete (podeExcluir in portuguese) = it should persist 'Y' or 'N' ('Yes' in portuguese is 'Sim')
		/// - idUser to know what user has those privileges
		/// Bellow we can see how to do this using a portuguese scheme. The logic is:
		/// --- if the user who logged in the system is an Administrator, then he/she canInsert, canUpdate and canDelete
		/// --- else then we will look at the functions that we have got from the serve to see if the user has those access
    /// This mixin will be used by controllers that will refresh insert, delete and update functions of the screen.
		
		canInsert = Session.loggedInUser.administrador == 'S'
      ? true
      : Session.accessControlList.where( ((t) => t.funcaoNome?.toLowerCase() == functionName.toLowerCase()) ).toList().isNotEmpty
          ? Session.accessControlList.where( ((t) => t.funcaoNome?.toLowerCase() == functionName) ).toList()[0].podeInserir == 'S'
          : false;
     canUpdate = Session.loggedInUser.administrador == 'S'
      ? true
      : Session.accessControlList.where( ((t) => t.funcaoNome?.toLowerCase() == functionName.toLowerCase()) ).toList().isNotEmpty
          ? Session.accessControlList.where( ((t) => t.funcaoNome?.toLowerCase() == functionName.toLowerCase()) ).toList()[0].podeAlterar == 'S'
          : false;
     canDelete = Session.loggedInUser.administrador == 'S'
      ? true
      : Session.accessControlList.where( ((t) => t.funcaoNome?.toLowerCase() == functionName.toLowerCase()) ).toList().isNotEmpty
          ? Session.accessControlList.where( ((t) => t.funcaoNome?.toLowerCase() == functionName.toLowerCase()) ).toList()[0].podeExcluir == 'S'
          : false;
  }

}