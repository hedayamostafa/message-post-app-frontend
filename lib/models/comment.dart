class Comment {
  final String body;
  final String author;
  final DateTime datePosted;

  Comment({
    required this.body,
    required this.author,
    required this.datePosted,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      body: json['body'] ?? 'No content',
      author: json['author'] ?? 'Anonymous',
      datePosted: DateTime.tryParse(json['datePosted'] ?? '') ?? DateTime.now(),
    );
  }
}
