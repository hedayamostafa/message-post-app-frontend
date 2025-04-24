import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:message_post_frontend/services/auth_service.dart';
import '../constants/api_constants.dart';
import '../models/comment.dart';

class CommentPage {
  Future<void> createComment(String postId, String commentBody) async {
    final token = await _authService.getStoredToken();

    print("inside create");

    final response = await http.post(
      Uri.parse('${ApiConstants.postsEndpoint}/$postId/comments'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'body': commentBody}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to post comment');
    }
  }
    final _authService = AuthService();

  Future<List<Comment>> fetchComments(int postId) async {
    final token = await _authService.getStoredToken();

    final response = await http.get(
      Uri.parse('${ApiConstants.postsEndpoint}/$postId/comments'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
