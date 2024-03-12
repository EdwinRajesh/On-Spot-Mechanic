// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String text;
  final bool display;
  const TextFieldWidget({super.key, required this.text, required this.display});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: TextField(
          obscureText: display,
          decoration: InputDecoration(
            hintText: text,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    BorderSide(color: const Color.fromARGB(255, 145, 16, 168))),
            fillColor: Colors.grey[200],
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purple),
            ),
          ),
        ));
  }
}
