import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:message_post_frontend/constants/api_constants.dart';
import 'package:message_post_frontend/services/auth_service.dart';

// Page for POST request - Create a Post
class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  String _response = '';

Future<void> _createPost(String subject, String body) async {
    final authService = AuthService();
    final token = await authService.getStoredToken();

    if (token == null) {
      setState(() {
        _response = 'User not authenticated. Please log in.';
      });
      return;
    }

  final response = await http.post(
    Uri.parse(ApiConstants.postsEndpoint),
    headers: <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'subject': subject,
      'body': body,
    }),
  );

  if (response.statusCode >= 200 && response.statusCode < 300) {
    // If status code is in the 2xx range (success codes)
    setState(() {
      _response = 'Post created successfully';
    });
  } else {
    // If status code is not in the 2xx range
    setState(() {
      _response = 'Failed to create post. Status: ${response.statusCode}';
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POST: Create a Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: subjectController,
              decoration: InputDecoration(labelText: 'Subject'),
            ),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(labelText: 'Body'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String subject = subjectController.text;
                String body = bodyController.text;
                if (subject.isNotEmpty && body.isNotEmpty) {
                  _createPost(subject, body);
                } else {
                  setState(() {
                    _response = 'Please fill in both fields';
                  });
                }
              },
              child: Text('Create Post'),
            ),
            SizedBox(height: 20),
            Text(
              _response,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}