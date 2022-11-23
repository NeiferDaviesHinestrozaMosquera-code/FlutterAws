// 1
abstract class AuthCredentials {
  final String username;
  final String password;

  AuthCredentials({required this.username, required this.password});
}

// 2 ACA ES DONDE SE DA ACCESO A LA I NFORMACION CON LAS CREDENCIALES BASICAS
class LoginCredentials extends AuthCredentials {
  LoginCredentials({required String username, required String password})
      : super(username: username, password: password);
}

// 3 CASI LO MISMO QUE LA PASADA C
class SignUpCredentials extends AuthCredentials {
  final String email;

  SignUpCredentials({required String username, required String password, required this.email})
      : super(username: username, password: password);
}