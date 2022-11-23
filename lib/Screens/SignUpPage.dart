import 'package:flutter/material.dart';
import 'package:flutteraws/Services/Auth_Credentials.dart';

class SignUpPage extends StatefulWidget {

  final ValueChanged<SignUpCredentials> didProvideCredentials;

  final VoidCallback shouldShowLogin;

  SignUpPage({Key? key, required this.shouldShowLogin, required this.didProvideCredentials}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 40),
          child: Stack(children: [
            // Sign Up Form
            _signUpForm(),

            // Login Button
            Container(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                  onPressed: widget.shouldShowLogin,
                  child: Text('Already have an account? Login.')),
            )
          ])),
    );
  }

  Widget _signUpForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Username TextField
        TextField(
          controller: _usernameController,
          decoration:
              InputDecoration(icon: Icon(Icons.person), labelText: 'Username',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        ),

        SizedBox(height: 10,),

        // Email TextField
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration:
              InputDecoration(icon: Icon(Icons.mail), labelText: 'Email',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
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

        SizedBox(height: 10,),

        // rePassword TextField
        TextField(
          controller: _repasswordController,
          decoration: InputDecoration(
              icon: Icon(Icons.lock_open), labelText: 'Password',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),

        SizedBox(height: 10,),

        // Sign Up Button
        TextButton(
            onPressed: _signUp,
            child: Text('Sign Up'),
        )
      ],
    );
  }

  void _signUp() {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final repassword = _repasswordController.text.trim();

    print('username: $username');
    print('email: $email');
    print('password: $password');
    print('repassword: $repassword');

    
    ///PASAMOS CREDENCIALES TAMBIEN ACA 
    
    final credentials = SignUpCredentials(
    username: username, 
    email: email, 
    password: password
      );
    widget.didProvideCredentials(credentials);
  }
}