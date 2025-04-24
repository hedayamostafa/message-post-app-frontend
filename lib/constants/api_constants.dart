class ApiConstants {
  static const String baseUrl = 'http://localhost:8080/api';
 // static const String baseUrl = 'https://backend-rest-385011.ew.r.appspot.com/api';
  static const String postsEndpoint = '$baseUrl/posts';
  static String postById(int id) => '$baseUrl/posts/$id';
}