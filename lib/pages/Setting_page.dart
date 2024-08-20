//ignore_for_file:prefer_const_constructors
import 'package:doc_wizard/pages/About_page.dart';
import 'package:doc_wizard/pages/FeedbackForm.dart';
import 'package:doc_wizard/pages/TNC_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doc_wizard/pages/UserInfo_page.dart';
import 'package:doc_wizard/pages/Login_page.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _Setting();
}

class _Setting extends State<Setting> {
  Color icon_color = Color.fromARGB(255, 155, 98, 101);

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    setState(() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            leading: Icon(
              Icons.person,
              color: icon_color,
              size: 35,
            ),
            title: Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // subtitle: Text('Name,e-mail,Number'),
            onTap: () {
              setState(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserInfo()));
              });
            },
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.contacts,
          //     // IconData(0xe18f, fontFamily: 'MaterialIcons'),
          //     color: icon_color,
          //     size: 35,
          //   ),
          //   title: Text(
          //     'Contact Us',
          //     style: TextStyle(fontWeight: FontWeight.bold),
          //   ),
          //   onTap: () {},
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.question_answer_rounded,
          //     // IconData(0xf00cf, fontFamily: 'MaterialIcons'),
          //     color: icon_color,
          //     size: 35,
          //   ),
          //   title: Text(
          //     'FAQ',
          //     style: TextStyle(fontWeight: FontWeight.bold),
          //   ),
          //   onTap: () {},
          // ),
          ListTile(
            leading: Icon(
              Icons.feedback,
              // IconData(0xe260, fontFamily: 'MaterialIcons'),
              color: icon_color,
              size: 35,
            ),
            title: Text(
              'Feedback',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FeedBack()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.policy,
              // IconData(0xe4d9, fontFamily: 'MaterialIcons'),
              // color: Color(0xFF005F73),
              color: icon_color,
              size: 35,
            ),
            title: Text(
              'Terms & Conditions',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // setState(() {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TNC()));
              // });
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: icon_color,
              size: 35,
            ),
            title: Text(
              'About',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              setState(() {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => About()));
              });
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: icon_color,
              size: 35,
            ),
            title: Text(
              'Logout',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              AlertDialog alert = AlertDialog(
                // backgroundColor: Color.fromARGB(255, 203, 171, 146),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                title: Text('Logout'),
                content: Text('Do You Want to Logout ?'),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 146, 141, 133),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 3, 106, 115),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: _logout,
                    child: Text('Logout'),
                  ),
                ],
              );
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
