import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function() onTap;
  final String name;
  const MyButton({super.key, required this.onTap, required this.name});

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: onTap, child: Text(name));
  }
}
