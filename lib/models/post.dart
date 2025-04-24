class Post {
  final int id;
  final String auther;
  final String creationDate;
  final String changeDate;
  final String subject;
  final String body;


  Post({
    required this.id,
    required this.auther,
    required this.creationDate,
    required this.changeDate,
    required this.subject,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      auther: json['auther'],
      creationDate: json['creationDate'].toString(),
      changeDate: json['changeDate'].toString(),
      subject: json['subject'],
      body: json['body'],
    );
  }
}
