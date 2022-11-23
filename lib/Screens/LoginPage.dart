import 'package:flutter/material.dart';
import 'package:flutteraws/Services/Auth_Credentials.dart';

class LoginPage extends StatefulWidget {

  final ValueChanged<LoginCredentials> didProvideCredentials;


  final VoidCallback shouldShowSignUp;

  LoginPage({Key? key, required this.shouldShowSignUp, required this.didProvideCredentials}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // 1 Los datos a pedir ::: usuario / contraseña
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 2
    return Scaffold(
      // 3
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 40),
          // 4
          child: Stack(children: [
            // Login Form
            _loginForm(),

            // 6
            // Sign Up Button
            Container(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                  onPressed: widget.shouldShowSignUp, ///REVISAR POR SI ALGO
                  child: Text('Don\'t have an account? Sign up.')),
            )
          ])),
    );
  }

  // 5
  Widget _loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Username TextField
        TextField(
          controller: _usernameController,
          decoration:
              InputDecoration(icon: Icon(Icons.mail), labelText: 'Username',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        ),

        SizedBox(height: 10,),
        // Password TextField
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
              icon: Icon(Icons.lock_open), labelText: 'Password',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),

        // Login Button
        TextButton(
            onPressed: _login,
            child: Text('Login'),
            
            //color: Theme.of(context).accentColor)
        )
      ],
    );
  }

   // 7
  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    print('username: $username');
    print('password: $password');

    //PASAR CREDENCIALES  DE UN ESTADO A OTRO
    final credentials =
    LoginCredentials(username: username, password: password);
    widget.didProvideCredentials(credentials);
  }
}