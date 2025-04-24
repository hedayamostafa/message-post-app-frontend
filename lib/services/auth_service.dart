import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '1021485559362-d77bcad9h1nufcvh8kfv3tq3pgafdppb.apps.googleusercontent.com',
    scopes: ['email', 'profile', 'openid'],
  );


Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account == null) {
        return null;
      }

      final GoogleSignInAuthentication auth = await account.authentication;
      final String? accessToken = auth.accessToken;
      //final String?idToken = auth.idToken;

      print('accessToken: $accessToken'); 

      if (accessToken != null) {
        await _secureStorage.write(key: 'access_token', value: accessToken);
      }

      return accessToken;
    } catch (e) {
      print('Error during Google sign-in: $e');
    }
    return null;
  }

  Future<String?> getStoredToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  Future<bool> isUserAuthenticated() async {
    final token = await _secureStorage.read(key: 'access_token');
    return token != null;
  }


  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _secureStorage.delete(key: 'access_token');
  }
}

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';

// class AuthService {
//   final _storage = const FlutterSecureStorage();
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'email',
//       'profile',
//       'openid',
//     ],
//   );

//   // Sign in and store ID token

// Future<bool> signInWithGoogle() async {
//   try {
//     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//     if (googleUser == null) {
//       // User canceled
//       return false;
//     }

//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//     final String? idToken = googleAuth.idToken;

//     if (idToken != null) {
//       final bool isExpired = JwtDecoder.isExpired(idToken);
//       if (isExpired) {
//         print('ID Token has expired');
//         return false;
//       }

//       await _storage.write(key: 'token', value: idToken);
//       return true;
//     } else {
//       print('ID Token is null');
//       return false;
//     }
//   } catch (e) {
//     print('Google Sign-In failed: $e');
//     return false;
//   }
// }


//   // Future<bool> signInWithGoogle() async {
//   //   try {
//   //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//   //     if (googleUser == null) {
//   //       // User canceled the sign-in process
//   //       return false;
//   //     }

//   //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//   //     final String? idToken = googleAuth.idToken;

//   //     if (idToken != null) {
//   //       // Store the token in secure storage
//   //       await _storage.write(key: 'token', value: idToken);
//   //       return true;
//   //     } else {
//   //       return false;
//   //     }
//   //   } catch (e) {
//   //     print('Google Sign-In failed: $e');
//   //     return false;
//   //   }
//   // }

//   // Check if user is authenticated by checking for a stored token
//   Future<bool> isUserAuthenticated() async {
//     final String? token = await _storage.read(key: 'token');
//     return token != null && token.isNotEmpty;
//   }

//   // Get stored ID token
//   Future<String?> getStoredToken() async {
//     return await _storage.read(key: 'token');
//   }

//   // Clear token and sign out the user
//   Future<void> signOut() async {
//     await _googleSignIn.signOut();
//     await _storage.delete(key: 'token');
//   }
// }


// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   final _storage = const FlutterSecureStorage();
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: [
//       'email',
//       'profile',
//       'openid',
//     ],
//   );

//   // Sign in and store ID token
//   Future<bool> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//       if (googleUser == null) {
//         // User canceled
//         return false;
//       }

//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//       final String? idToken = googleAuth.idToken;

//       if (idToken != null) {
//         await _storage.write(key: 'token', value: idToken);
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       print('Google Sign-In failed: $e');
//       return false;
//     }
//   }

//   // Get stored ID token
//   Future<String?> getStoredToken() async {
//     return await _storage.read(key: 'token');
//   }

//   // Clear token
//   Future<void> signOut() async {
//     await _googleSignIn.signOut();
//     await _storage.delete(key: 'token');
//   }
// }


