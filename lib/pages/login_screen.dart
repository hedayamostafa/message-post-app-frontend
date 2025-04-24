import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'dart:developer'; // Use log

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  bool _isLoading = false; // State for loading indicator

  Future<void> _handleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    String? idToken = await _authService.signInWithGoogle();

    // Check if the widget is still mounted before proceeding
    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (idToken != null) {
      log("Login successful, navigating to '/'");
      // Successfully authenticated, navigate to the root ('/')
      // The root route's FutureBuilder will detect the logged-in state
      // and redirect to MainScreen.
      Navigator.pushReplacementNamed(context, '/');
    } else {
      log("Login failed");
      // Authentication failed
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Could not sign in with Google. Please check your connection and try again.'), // More specific message
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator() // Show loading indicator
            : ElevatedButton.icon( // Use icon button for better UX
                icon: const Icon(Icons.login), // Example icon
                label: const Text('Sign in with Google'),
                onPressed: _handleSignIn, // Call the handler method
              ),
      ),
    );
  }
}