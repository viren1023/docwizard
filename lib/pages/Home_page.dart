import 'package:flutter/material.dart';
import '../utils/choseFile.dart';
// import 'package:file_picker/file_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 100,
          ),
          Center(
            child: Container(
              // color: Colors.blueGrey[700],
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/txt_to_pdf.png',
                    height: 150,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                  ),
                  RichText(
                      text: const TextSpan(
                          style: TextStyle(
                              fontSize: 24,
                              letterSpacing: 2,
                              color: Colors.black,
                              fontFamily: 'Anta'),
                          children: [
                        TextSpan(
                            text: 'TXT',
                            style: TextStyle(
                                color: Color.fromARGB(255, 155, 98, 101),
                                fontWeight: FontWeight.bold)),
                        TextSpan(text: ' to '),
                        TextSpan(
                            text: 'PDF',
                            style: TextStyle(
                                color: Color.fromARGB(255, 155, 98, 101),
                                fontWeight: FontWeight.bold))
                      ])),
                  const SizedBox(
                    height: 30,
                  ),
                  IntrinsicWidth(
                    child: Container(
                      padding: EdgeInsets.all(0),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(
                              255, 212, 131, 105), // Background color
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () => pickTextFile(context),
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    const Color.fromARGB(255, 212, 131, 105)),
                            child: const Row(
                              children: [
                                Icon(Icons.upload),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Select File',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            onSelected: (String result) {
                              // change of page or just content logic
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: '0',
                                child: Text('TXT to PDF'),
                              ),
                              const PopupMenuItem<String>(
                                value: '1',
                                child: Text('Image to PDF'),
                              ),
                              const PopupMenuItem<String>(
                                value: '2',
                                child: Text('Code to PDF'),
                              ),
                            ],
                            child: const IconButton(
                                onPressed: null,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Spacer(flex: 7),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
