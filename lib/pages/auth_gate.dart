// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// //import '../services/auth_service.dart';
// import '../main.dart';
// import 'login_screen.dart';

// class AuthGate extends StatefulWidget {
//   @override
//   _AuthGateState createState() => _AuthGateState();
// }

// class _AuthGateState extends State<AuthGate> {
//   //final AuthService _authService = AuthService();
//   final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

//   late Future<bool> _isAuthenticated;

//   @override
//   void initState() {
//     super.initState();
//     _isAuthenticated = _checkAuthenticationStatus();
//   }

//   Future<bool> _checkAuthenticationStatus() async {
//     final token = await _secureStorage.read(key: 'access_token');
//     return token != null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<bool>(
//       future: _isAuthenticated,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }

//         if (snapshot.hasData && snapshot.data == true) {
//           return MainScreen(); // User is authenticated
//         } else {
//           return LoginScreen(); // User is not authenticated
//         }
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import '../services/auth_service.dart';
// import '../main.dart';
// import 'login_screen.dart';

// class AuthGate extends StatefulWidget {
//   @override
//   _AuthGateState createState() => _AuthGateState();
// }

// class _AuthGateState extends State<AuthGate> {
//   final AuthService _authService = AuthService();
//   final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

//   Future<bool> _attemptLogin() async {
//     // Sign in and get the token
//     final token = await _authService.signInAndGetIdToken();

//     // If successful, store it securely
//     if (token != null) {
//       await _secureStorage.write(key: 'access_token', value: token);
//       return true;
//     } else {
//       return false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<bool>(
//       future: _attemptLogin(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }

//         if (snapshot.hasData && snapshot.data == true) {
//           return MainScreen(); // User is authenticated
//         } else {
//           return LoginScreen(); // User is not authenticated
//         }
//       },
//     );
//   }
// }