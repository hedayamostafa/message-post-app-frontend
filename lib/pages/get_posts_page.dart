import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:message_post_frontend/constants/api_constants.dart';
import 'package:message_post_frontend/widgets/comment_section.dart';
import '../services/auth_service.dart';
import 'dart:convert';
import '../../models/post.dart';

class GetPostsPage extends StatefulWidget {
  @override
  _GetPostsPageState createState() => _GetPostsPageState();
}

class _GetPostsPageState extends State<GetPostsPage> {
  List<Post> posts = [];
  String _response = '';
  bool _isLoading = false;

  Future<void> _getPosts() async {
    setState(() {
      _isLoading = true;
      _response = '';
    });

    final authService = AuthService();
    final token = await authService.getStoredToken();

    if (token == null) {
      setState(() {
        _isLoading = false;
        _response = 'User not authenticated. Please log in.';
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(ApiConstants.postsEndpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          posts = data.map((item) => Post.fromJson(item)).toList();
          _response = '';
        });
      } else {
        setState(() {
          _response = 'Failed to load posts: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _response = 'An error occurred: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget buildPostCard(Post post) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${post.id}'),
            Text('Author Email: ${post.auther}'),
            Text('Created: ${post.creationDate}'),
            Text('Updated: ${post.changeDate}'),
            const SizedBox(height: 6),
            Text('Subject: ${post.subject}', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Body: ${post.body}'),
            CommentSection(postId: post.id),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GET: Get All Posts')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _getPosts,
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('Fetch Posts'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: posts.isEmpty
                  ? Center(child: Text(_response.isNotEmpty ? _response : 'No posts available'))
                  : ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) => buildPostCard(posts[index]),
                    ),
            ),
            if (_response.isNotEmpty && posts.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  _response,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}