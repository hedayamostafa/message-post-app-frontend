import 'package:flutter/material.dart';
import 'package:message_post_frontend/models/comment.dart';
import 'package:message_post_frontend/pages/comment_page.dart';

class CommentSection extends StatefulWidget {
  final int postId;

  const CommentSection({Key? key, required this.postId}) : super(key: key);

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final CommentPage _commentService = CommentPage();
  final TextEditingController _controller = TextEditingController();

  Future<List<Comment>>? _commentsFuture;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  void _loadComments() {
    setState(() {
      _commentsFuture = _commentService.fetchComments(widget.postId);
    });
  }

  void _submitComment() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    try {
          print("herrreeeee");
      await _commentService.createComment(widget.postId.toString(), text);
        _controller.clear();
      _loadComments(); // Refresh
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to post comment')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Comments", style: TextStyle(fontWeight: FontWeight.bold)),
        FutureBuilder<List<Comment>>(
          future: _commentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No comments yet.');
            }

            final comments = snapshot.data!;
            return Column(
              children: comments.map((comment) {
                return ListTile(
                  title: Text(comment.body),
                  subtitle: Text('${comment.author} - ${comment.datePosted.toLocal()}'),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Add a comment',
            suffixIcon: IconButton(
              icon: const Icon(Icons.send),
              onPressed: _submitComment,
            ),
          ),
        ),
      ],
    );
  }
}
