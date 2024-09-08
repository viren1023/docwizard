// import 'dart:io';
//  distributionUrl=https\://services.gradle.org/distributions/gradle-7.6.3-all.zip
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/globalStateProvider.dart';

import 'package:doc_wizard/pages/Setting_page.dart';
import 'package:doc_wizard/splashScreen.dart';
import 'package:doc_wizard/pages/Home_page.dart';
import 'package:doc_wizard/pages/Files_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GlobalStateProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splashscreen(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            // color: Colors.red,
            foregroundColor: Color.fromARGB(255, 203, 171, 146),
            backgroundColor: Color.fromARGB(255, 3, 46, 64),
            titleSpacing: 5 // App bar color
            ),
        popupMenuTheme:
            const PopupMenuThemeData(color: Color.fromARGB(255, 214, 200, 188)),
      ),
    ),
  ));
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int Index = 1;
  var page = [const Files(), const Home(), const Setting()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 46, 64),
        title: const Text(
          'DocWizard',
          style: TextStyle(
              color: Color.fromARGB(255, 203, 171, 146),
              letterSpacing: 2,
              fontFamily: 'Anta'),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: page[Index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // elevation: 100,
        // backgroundColor: Color.fromARGB(255, 196, 181, 169),
        backgroundColor: const Color.fromARGB(255, 3, 46, 64),
        unselectedItemColor: const Color.fromARGB(255, 146, 141, 133),
        selectedItemColor: const Color.fromARGB(255, 203, 171, 146),
        currentIndex: Index,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy),
            label: 'Files',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          setState(() {
            Index = index;
          });
        },
      ),
    );
  }
}
