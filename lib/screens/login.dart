import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/myButton.dart';
import '../components/myTextField.dart';

class Login extends StatefulWidget {
  final Function() onTap;
  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final emailCont = TextEditingController();
  final passwordCont = TextEditingController();

  showAlert(String msg){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(msg),
            actions: [
              FilledButton(onPressed: (){Navigator.pop(context);},
                  child: const Text('Okay')
              )
            ],
          );
        }
    );
  }

  login()async{
    showDialog(context: context, builder: (context) {
          return const Center(child: CircularProgressIndicator());}
    );
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailCont.text,
          password: passwordCont.text
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch(e){
      if(e.code=="user-not-found"){
        showAlert('No User Found');
      } else if(e.code=="wrong-password"){
        showAlert('Wrong password');
      }
    }
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(controller: emailCont, hint: 'E-mail', password: false,),
            MyTextField(controller: passwordCont, hint: 'Password', password: true,),
            MyButton(onTap:login, name: 'Login',),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an Account?'),
                TextButton(onPressed: widget.onTap, child: Text('Sign Up'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
