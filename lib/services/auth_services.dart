import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyARaCltIbTAutBNWh2RqyGxXzNw8J2RZlU';
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email' : email,
      'password': password
    };
    final url = Uri.https(_baseUrl, '/v1/accounts:signUp'){
      
    }
  }
}
