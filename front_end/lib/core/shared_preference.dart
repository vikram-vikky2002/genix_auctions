import 'package:shared_preferences/shared_preferences.dart';

// Save token and user ID
Future<void> saveUserCredentials(
    String token, String userId, String userName) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
  prefs.setString('userId', userId);
  prefs.setString('userName', userName);
}

// Get token and user ID
Future<Map<String, String?>> getUserCredentials() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  String? userId = prefs.getString('userId');
  String? userName = prefs.getString('userName');
  return {'token': token, 'userId': userId, 'userName': userName};
}

// Clear token and user ID
Future<void> clearUserCredentials() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('token');
  prefs.remove('userId');
  prefs.remove('userName');
}
