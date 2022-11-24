import 'dart:async';

import 'package:flutteraws/Services/Auth_Credentials.dart';  ///REVISAR ESTO XXX



// 1 ACA SE MANEJAN LOS ESTADOS DE LA APLICACION CON ESTA CONDICION
enum AuthFlowStatus { login, signUp, verification, session }

// 2
class AuthState {  //ACA CONTENEMOS LA INFORMACION DEL PUNTO UNO PARA USAR MAS ADELANTE 
  final AuthFlowStatus authFlowStatus;

  AuthState({required this.authFlowStatus});
}

// 3
class AuthService {  //ACA CONTROLAMOS LOS DOS PUNTOS ANTERIORES (ES UN ADMIN)
  // 4
  final authStateController = StreamController<AuthState>();  ///ACA ENVIAMOS EL LA INFORMACION AL PUNTO 2

  // 5
  void showSignUp() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.signUp); //SE ENCARGA DE ACTUALIZAR EL STREAM PARA EL PUNTO 2
    authStateController.add(state);
  }

  // 6
  void showLogin() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.login);  //CON ESTO REDIRIGIMOS LA APLICAICON PARA EL INICIO DE SESION
    authStateController.add(state);
  }

  // 1
  void loginWithCredentials(AuthCredentials credentials) {
  final state = AuthState(authFlowStatus: AuthFlowStatus.session);
  authStateController.add(state);
  }

  // 2
  void signUpWithCredentials(SignUpCredentials credentials) {
  final state = AuthState(authFlowStatus: AuthFlowStatus.verification);
  authStateController.add(state);
  }

  //ACA CONTROLAMOS EL CODIGO PARA VERIFICAR 
  void verifyCode(String verificationCode) {
  final state = AuthState(authFlowStatus: AuthFlowStatus.session);
  authStateController.add(state);
  }

  //ACA CERRAMOS SESION
 void logOut() {
 final state = AuthState(authFlowStatus: AuthFlowStatus.login);
 authStateController.add(state);
}
}