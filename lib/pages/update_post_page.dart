import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:message_post_frontend/constants/api_constants.dart';
import 'package:message_post_frontend/services/auth_service.dart';

// Page for PUT request - Update a Post
class UpdatePostPage extends StatefulWidget {
  @override
  _UpdatePostPageState createState() => _UpdatePostPageState();
}

class _UpdatePostPageState extends State<UpdatePostPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  String _response = '';

  Future<void> _updatePost(int id, String subject, String body) async {
    final authService = AuthService();
    final token = await authService.getStoredToken();

    if (token == null) {
      setState(() {
        _response = 'User not authenticated. Please log in.';
      });
      return;
    }

    final response = await http.put(
      Uri.parse(ApiConstants.postById(id)),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'subject': subject,
        'body': body,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _response = 'Post updated successfully';
      });
    } else {
      setState(() {
        _response = 'Failed to update post';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PUT: Update a Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: 'Post ID'),
              keyboardType: TextInputType.number,
            ),
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
                int? id = int.tryParse(idController.text);
                String subject = subjectController.text;
                String body = bodyController.text;
                if (id != null && subject.isNotEmpty && body.isNotEmpty) {
                  _updatePost(id, subject, body);
                } else {
                  setState(() {
                    _response = 'Please fill in all fields correctly';
                  });
                }
              },
              child: Text('Update Post'),
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
