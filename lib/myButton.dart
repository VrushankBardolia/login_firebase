import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function() onTap;
  final String name;
  const MyButton({super.key, required this.onTap, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FilledButton(onPressed: onTap, child: Text(name)),
    );
  }
}
