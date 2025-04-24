import 'package:flutter/material.dart';
import 'pages/login_screen.dart';
import 'pages/main_screen.dart';
import 'services/auth_service.dart';
import 'pages/create_post_page.dart';
import 'pages/get_posts_page.dart';
import 'pages/update_post_page.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Instance of the AuthService
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder(
              future: _authService.isUserAuthenticated(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData && snapshot.data == true) {
                  // If user is authenticated, show the MainScreen
                  return MainScreen();
                } else {
                  // If not authenticated, show Login Screen
                  return LoginScreen(); // You need to create a LoginScreen
                }
              },
            ),
        '/getPosts': (context) => GetPostsPage(),
        '/createPost': (context) => CreatePostPage(),
        '/updatePost': (context) => UpdatePostPage(),
      },
    );
  }
}