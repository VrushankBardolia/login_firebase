import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/myButton.dart';
import '../components/myTextField.dart';

class Signup extends StatefulWidget {
  final Function()? onTap;
  const Signup({super.key, required this.onTap});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final emailCont=TextEditingController();
  final passwordCont=TextEditingController();
  final CpasswordCont=TextEditingController();

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

  signUp()async{
    if(passwordCont.text==CpasswordCont.text){
      try{
        showDialog(context: context, builder: (context) {
          return const Center(child: CircularProgressIndicator());}
        );
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailCont.text,
            password: passwordCont.text
        );
        Navigator.pop(context);
      }
      on FirebaseAuthException catch(e){
        if(e.code=='weak-password'){
          showAlert('Password is Too Weak');
        }
        if(e.code=="email-already-in-use"){
          showAlert('E-mail is already signed in');
        }
      }
    }else{
      showAlert('Password & Confirm Password Should Be Same');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUP'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(controller: emailCont, hint: 'E-mail', password: false,),
            MyTextField(controller: passwordCont, hint: 'Password', password: true,),
            MyTextField(controller: CpasswordCont, hint: 'Confirm Password', password: true,),
            MyButton(onTap:signUp, name: 'Login',),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an Account?'),
                TextButton(onPressed: widget.onTap, child: Text('Login'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
