//ignore_for_file:prefer_const_constructors

// import 'package:doc_wizard/pages/UserInfo_page.dart';
import 'package:flutter/material.dart';

// import 'package:doc_wizard/pages/Login_page.dart';
// import 'package:doc_wizard/pages/AppDetails_page.dart';

// import 'package:mind_breakar/app_detail.dart';

class Files extends StatefulWidget {
  const Files({super.key});

  @override
  State<Files> createState() => _Files();
}

class _Files extends State<Files> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Opacity(
        opacity: 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              child: Image.asset('assets/images/app_logo.png'),
            ),
            SizedBox(height: 10),
            Text(
              'No Files yet',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    ));
  }
}
