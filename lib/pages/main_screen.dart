// pages/main_screen.dart
import 'package:flutter/material.dart';
import '../services/auth_service.dart'; // Import AuthService

class MainScreen extends StatelessWidget {
  final AuthService _authService = AuthService(); // Get instance of AuthService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await _authService.signOut();
              // Navigate back to the root, which will redirect to LoginScreen
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/getPosts');
                },
                child: Text('View Posts (GET)'),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/createPost');
                },
                child: Text('Create Post (POST)'),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  // You might need to pass an ID to the update page
                  // For now, just navigate. Adjust as needed.
                  Navigator.pushNamed(context, '/updatePost');
                },
                child: Text('Update Post (PUT)'),
              ),
              // Add more navigation buttons if needed
            ],
          ),
        ),
      ),
    );
  }
}