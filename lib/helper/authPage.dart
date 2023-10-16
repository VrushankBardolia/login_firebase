import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/screens/home.dart';
import 'package:login_firebase/helper/loginORsignup.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
         if(snapshot.hasData){
           return Home();
         }
         else{
           return const LoginORsignup();
         }
        }
      ),
    );
  }
}
