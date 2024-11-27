import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//  USED FOR TRAKING LOGs OF CONVERTED FILES BY USER

Future<void> insert_data(BuildContext context, name, path, size, time) async {
  print("in insert_data");
  String url = "http://192.168.0.113/doc_wizard/index.php/save_record";
  // String url = "http://192.168.52.78/doc_wizard/index.php/save_record";

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  print("Token : ${token}");
  size = size.toString();
  time = time.toString();
  // print(token.runtimeType);
  // print(name.runtimeType);
  // print(size.runtimeType);
  // print(path.runtimeType);
  // print(time.runtimeType);

  print(size);
  print(time);
  var res = await http.post(Uri.parse(url), body: {
    "token": token,
    "name": name,
    "path": path,
    "size": size,
    "time": time
  });

  try {
    var jsonResponse = await jsonDecode(res.body);
    print(jsonResponse);
  } catch (e) {
    print(e);
  }
  print("response came");
}
