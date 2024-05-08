import 'package:chatgpt_clone/components/my_buttons.dart';
import 'package:chatgpt_clone/components/my_textfield.dart';
import 'package:chatgpt_clone/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function() onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 5),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 35.0),
                      child: Text("Login",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold)),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 35.0),
                      child: Text("Please login to continue",
                          style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(height: 30),
                    // Email TextField
                    MyTextField(
                      hintText: "Email",
                      obscureText: false,
                      controller: _emailController,
                      icon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 10),
                    // Password TextField
                    MyTextField(
                      hintText: "Password",
                      obscureText: true,
                      controller: _passwordController,
                      icon: Icons.lock_outline,
                    ),
                    const SizedBox(height: 25),
                    // Login Button
                    MyButton(
                      text: "Login",
                      onTap: () => authProvider.login(
                        context,
                        _emailController.text,
                        _passwordController.text,
                      ),
                      isLoading: authProvider.isLoading,
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
              const Spacer(flex: 4),
              // Register row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not a member? "),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Register Now",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
