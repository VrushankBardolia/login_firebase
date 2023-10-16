import 'package:flutter/material.dart';
import 'package:login_firebase/screens/login.dart';
import 'package:login_firebase/screens/signup.dart';

class LoginORsignup extends StatefulWidget {
  const LoginORsignup({super.key});

  @override
  State<LoginORsignup> createState() => _LoginORsignupState();
}

class _LoginORsignupState extends State<LoginORsignup> {

  bool showLogin = true;

  toggleScreen(){
    setState(() {
      showLogin= !showLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLogin){
      return Login(onTap: toggleScreen);
    } else{
      return Signup(onTap: toggleScreen);
    }
  }
}
