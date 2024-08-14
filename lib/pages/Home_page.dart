import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

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
          SizedBox(
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
                      text: TextSpan(
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
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result != null) {
                        // File file = File(result.files.single.path!);
                      } else {
                        // User canceled the picker
                      }
                    },
                    label: IntrinsicWidth(
                      child: Row(
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
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(16),
                        // side: BorderSide(width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 212, 131, 105)),
                    // backgroundColor: Colors.blueGrey[700]),
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
