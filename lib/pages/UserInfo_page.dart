import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfo();
}

class _UserInfo extends State<UserInfo> {
  Future<List<String>> _loadData(key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  // Color card_color = Color.fromARGB(255, 165, 166, 151);
  Color card_color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Person Information',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 25),
            CircleAvatar(
              radius: 60,
              child: Icon(Icons.person, size: 90),
            ),
            FutureBuilder(
              future: _loadData('signInCred'),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  final data = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        // Divider(height: 1),
                        Card(
                          color: card_color,
                          shadowColor: Colors.transparent,
                          child: ListTile(
                            title: Text('Name: ${data[0]}'),
                          ),
                        ),
                        Divider(height: 1),
                        Card(
                          color: card_color,
                          shadowColor: Colors.transparent,
                          child: ListTile(
                            title: Text('Email: ${data[1]}'),
                          ),
                        ),
                        Divider(height: 1),
                        Card(
                          color: card_color,
                          shadowColor: Colors.transparent,
                          child: ListTile(
                            title: Text('Password: ${data[2]}'),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
