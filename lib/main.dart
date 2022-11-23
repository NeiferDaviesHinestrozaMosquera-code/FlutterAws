import 'package:flutter/material.dart';
import 'package:flutteraws/Screens/LoginPage.dart';
import 'package:flutteraws/Screens/SignUpPage.dart';
import 'package:flutteraws/Screens/VerificationPage.dart';
import 'package:flutteraws/Services/Auth_Services.dart';

void main() {
  runApp(MyApp());
}

// 1
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final _authService = AuthService(); //PARA TRAER LA INFORMACION DE SERVICIOS

  @override
void initState() {
 super.initState();
 _authService.showLogin();
}

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo Gallery App',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      // 2
      home: StreamBuilder<AuthState>(  ///SE ENCARGA DE ESPERAR LA RESPUESTA DE AUTHSTATE

      // 2 ACA ACCEDEMOS A ALA INFORMACION
    stream: _authService.authStateController.stream,
    builder: (context, snapshot) {
      // 3 ESTE SE ENCARGA DE VERIFICAR QUE TENGA DATOS
      if (snapshot.hasData) {
        return Navigator(
          pages: [
            // 4
            // Show Login Page
            if (snapshot.data!.authFlowStatus == AuthFlowStatus.login)
              MaterialPage(child: LoginPage(shouldShowSignUp: _authService.showSignUp, didProvideCredentials:_authService.loginWithCredentials,)),

            // 5
            // Show Sign Up Page
           if (snapshot.data!.authFlowStatus == AuthFlowStatus.signUp)
              MaterialPage(child: SignUpPage(shouldShowLogin: _authService.showLogin, didProvideCredentials: _authService.signUpWithCredentials,)),
           
            //5.5 Verificacion
            if (snapshot.data!.authFlowStatus == AuthFlowStatus.verification)
            MaterialPage(child: VerificationPage(
            didProvideVerificationCode: _authService.verifyCode))
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      } else {
        // 6
        return Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      }
    }),
    );
  }
}