import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/myButton.dart';
import 'package:login_firebase/myTextField.dart';

class Login extends StatefulWidget {
  final Function()? onTap;

  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {

    final emailCont=TextEditingController();
    final passwordCont=TextEditingController();

    showAlert(String msg){
      return showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
                title: Text(msg),
              actions: [IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.ac_unit_sharp))],
            );
          }
      );
    }

    login() async{
      showDialog(
          context: context,
          builder: (context){
            return const Center(child: CircularProgressIndicator());
          }
      );
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailCont.text,
            password: passwordCont.text
        );
        Navigator.pop(context);
      } on FirebaseAuthException catch(e){
        if(e.code=="user-not-found"){
          print('No User Found');
          // showAlert('No User Found');
        } else if(e.code=="wrong-password"){
          showAlert('Wrong password');
        }
      }
      // Navigator.pop(context);
    }

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
                const SizedBox(width: 8),
                GestureDetector(
                    onTap: widget.onTap,
                    child: Text('Sign Up',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold
                      ),
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
