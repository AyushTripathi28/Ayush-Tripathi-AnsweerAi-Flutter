import 'package:chatgpt_clone/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  // Getters for loading state
  bool get isLoading => _isLoading;

  // Method to log in a user
  Future<void> login(
      BuildContext context, String email, String password) async {
    _setLoading(true);
    try {
      await _authService.signInWithEmailAndPassword(email, password);
    } catch (e) {
      _showErrorDialog(context, e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Method to register a user
  Future<void> register(BuildContext context, String name, String email,
      String password, String confirmPassword) async {
    if (password != confirmPassword) {
      _showErrorDialog(context, "Passwords do not match");
      return;
    }

    _setLoading(true);
    try {
      await _authService.signUpWithEmailAndPassword(name, email, password);
    } catch (e) {
      _showErrorDialog(context, e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Private method to update loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Helper function to show error dialogs
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
