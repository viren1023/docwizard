import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfo();
}

class _UserInfo extends State<UserInfo> {
  String url = "http://192.168.0.113/doc_wizard/index.php/auth";
  // late List<String> data;

  Future _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(token);
    print('in fun');
    var res = await http.post(Uri.parse(url), body: {'token': token});
    print(res.body);

    var jRes = await jsonDecode(res.body);
    print('res');
    // setState(() {
    //   data = [jRes['name'], jRes['email']];
    // });
    print(jRes['name']);
    print(['email']);
    return [jRes['name'], jRes['email']];
  }

  Color card_color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Person Information',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            const CircleAvatar(
              radius: 60,
              child: Icon(Icons.person, size: 90),
            ),
            FutureBuilder(
              future: _loadData(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  final data = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Divider(height: 1),
                        Card(
                          color: card_color,
                          shadowColor: Colors.transparent,
                          child: ListTile(
                            title: Text('Name: ${data[0]}'),
                          ),
                        ),
                        const Divider(height: 1),
                        Card(
                          color: card_color,
                          shadowColor: Colors.transparent,
                          child: ListTile(
                            title: Text('Email: ${data[1]}'),
                          ),
                        ),
                        // Divider(height: 1),
                        // Card(
                        //   color: card_color,
                        //   shadowColor: Colors.transparent,
                        //   child: ListTile(
                        //     title: Text('Password: ${data[2]}'),
                        //   ),
                        // ),
                      ],
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
