import 'package:shared_preferences/shared_preferences.dart';

void saveToken(String token, bool isAdmin) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  print(token);
  await prefs.setString('token', token);
  await prefs.setBool('isAdmin', isAdmin);

}
