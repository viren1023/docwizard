import 'dart:convert';
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
  // String url = "http://192.168.20.78/doc_wizard/index.php/auth";

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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Person Information',
          ),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: _loadData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final data = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textDirection: TextDirection.ltr,
                  children: [
                    const SizedBox(height: 25),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 80,
                      child: Image.asset('assets/images/avatar.png'),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Username
                          Text(
                            "Username:",
                            style: TextStyle(fontSize: 16),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 2),
                            decoration: BoxDecoration(
                              color: Color(0xFFDCDCDC),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              title: Text(
                                data[0],
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),

                          Text(
                            "Email:",
                            style: TextStyle(fontSize: 16),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 2),
                            decoration: BoxDecoration(
                              color: Color(0xFFDCDCDC),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              // tileColor: Color(0xFFDCDCDC),
                              title: Text(
                                data[1],
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
