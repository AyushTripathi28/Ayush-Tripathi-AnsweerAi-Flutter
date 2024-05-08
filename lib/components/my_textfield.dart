import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final IconData icon;
  const MyTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        style: const TextStyle(color: Colors.black),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          fillColor: Theme.of(context).colorScheme.inversePrimary,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
