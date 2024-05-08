import 'package:chatgpt_clone/services/auth/login_or_register.dart';
import 'package:chatgpt_clone/views/animated_main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const AnimatedMainPage();
            } else {
              return const LoginOrRegister();
            }
          }),
    );
  }
}
