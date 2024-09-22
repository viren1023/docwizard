import 'dart:io';
import 'package:doc_wizard/pages/previewFile.dart';
import 'package:doc_wizard/utils/convertPdfs.dart';
import 'package:doc_wizard/utils/createThumbnail.dart';
// import 'package:doc_wizard/providers/globalStateProvider.dart';
// import 'package:doc_wizard/utils/customWidget.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../utils/choseFile.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:file_picker/file_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  List<FileSystemEntity> _files = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      await _loadFiles();
    } else {
      setState(() {
        _errorMessage = 'Storage permission is required to access files.';
        _isLoading = false;
      });
    }
  }

  // Future<void> openPdf(final file) async {
  //   final path = file.path;
  //   final exists = await file.exists();
  //   if (exists) {
  //     print('File exists and is at: $path');
  //   } else {
  //     print('File does not exist at: $path');
  //   }
  //   print("in open ${file.path}");
  //   // await OpenFile.open(path);
  //   try {
  //     final result = await OpenFile.open(path);
  //     print('open');
  //   } catch (e) {
  //     print('Error opening file: $e');
  //   }
  //   print("after opening");
  // }

  Future<void> _loadFiles() async {
    try {
      final directory = Directory('/storage/emulated/0/Download/DocWizard');
      final List<FileSystemEntity> files = directory.listSync();
      setState(() {
        _files = files;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load files: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   body: SingleChildScrollView(
      //     child: Column(children: [
      //       const SizedBox(
      //         height: 100,
      //       ),
      //       Center(
      //         child: Container(
      //           // color: Colors.blueGrey[700],
      //           child: Column(
      //             children: [
      //               Image.asset(
      //                 'assets/images/txt_to_pdf.png',
      //                 height: 150,
      //                 filterQuality: FilterQuality.high,
      //                 fit: BoxFit.fill,
      //               ),
      //               RichText(
      //                   text: const TextSpan(
      //                       style: TextStyle(
      //                           fontSize: 24,
      //                           letterSpacing: 2,
      //                           color: Colors.black,
      //                           fontFamily: 'Anta'),
      //                       children: [
      //                     TextSpan(
      //                         text: 'TXT',
      //                         style: TextStyle(
      //                             color: Color.fromARGB(255, 155, 98, 101),
      //                             fontWeight: FontWeight.bold)),
      //                     TextSpan(text: ' to '),
      //                     TextSpan(
      //                         text: 'PDF',
      //                         style: TextStyle(
      //                             color: Color.fromARGB(255, 155, 98, 101),
      //                             fontWeight: FontWeight.bold))
      //                   ])),
      //               const SizedBox(
      //                 height: 30,
      //               ),
      //               IntrinsicWidth(
      //                 child: Container(
      //                   padding: const EdgeInsets.all(0),
      //                   decoration: const BoxDecoration(
      //                       color: Color.fromARGB(
      //                           255, 212, 131, 105), // Background color
      //                       borderRadius: BorderRadius.all(Radius.circular(8))),
      //                   child: Row(
      //                     children: [
      //                       TextButton(
      //                         onPressed: () async {
      //                           bool result = await pickTextFile(context);
      //                           if (result) {
      //                             Navigator.push(
      //                                 context,
      //                                 MaterialPageRoute(
      //                                     builder: (context) =>
      //                                         const PreviewPage()));
      //                           }
      //                         },
      //                         style: TextButton.styleFrom(
      //                             padding: const EdgeInsets.all(16),
      //                             shape: RoundedRectangleBorder(
      //                                 borderRadius: BorderRadius.circular(8)),
      //                             foregroundColor: Colors.white,
      //                             backgroundColor:
      //                                 const Color.fromARGB(255, 212, 131, 105)),
      //                         child: const Row(
      //                           children: [
      //                             Icon(Icons.upload),
      //                             SizedBox(
      //                               width: 5,
      //                             ),
      //                             Text(
      //                               'Select File',
      //                               style: TextStyle(fontSize: 16),
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //                       PopupMenuButton<String>(
      //                         onSelected: (String result) {},
      //                         itemBuilder: (BuildContext context) =>
      //                             <PopupMenuEntry<String>>[
      //                           const PopupMenuItem<String>(
      //                             value: '0',
      //                             child: Text('TXT to PDF'),
      //                           ),
      //                           const PopupMenuItem<String>(
      //                             value: '1',
      //                             child: Text('Image to PDF'),
      //                           ),
      //                           const PopupMenuItem<String>(
      //                             value: '2',
      //                             child: Text('Code to PDF'),
      //                           ),
      //                         ],
      //                         child: const IconButton(
      //                             onPressed: null,
      //                             icon: Icon(
      //                               Icons.arrow_drop_down,
      //                               color: Colors.white,
      //                             )),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ]),
      //   ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    // childAspectRatio: 1.5,
                  ),
                  itemCount: _files.length,
                  padding: EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    final file = _files[index];
                    return GestureDetector(
                      onTap: () => SaveAndOpenDocument.openPdf(file),
                      child: Container(
                          // margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.red,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Column(children: [
                              Expanded(
                                flex: 3,
                                child: FutureBuilder(
                                  future: createThumbnail(file.path),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        color: Colors.white,
                                        child: snapshot.data,
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  width: double.infinity,
                                  color: Colors.amber,
                                  child: Text(
                                    file.path.split('/').last,
                                  ),
                                ),
                              ),
                            ]),
                          )),
                    );
                  }),

      floatingActionButton: SpeedDial(
        spacing: 12,
        // animatedIcon: AnimatedIcons.event_add,
        activeIcon: Icons.close,
        icon: Icons.add,
        overlayColor: Colors.black,
        overlayOpacity: 0.3,
        animatedIconTheme: IconThemeData(size: 22.0),
        backgroundColor: Color.fromARGB(255, 212, 131, 105),
        foregroundColor: Colors.white,
        children: [
          SpeedDialChild(
              // labelBackgroundColor: Color.fromARGB(255, 212, 131, 105),
              // backgroundColor: Color.fromARGB(255, 203, 171, 146),
              child: Icon(
                Icons.looks_one_rounded,
                color: Color.fromARGB(255, 3, 46, 64),
              ),
              label: 'One',
              shape: CircleBorder(),
              onTap: () async {
                bool result = await pickTextFile(context);
                if (result) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PreviewPage()));
                }
              }),
          SpeedDialChild(
              child: Icon(
                Icons.looks_two_rounded,
                color: Color.fromARGB(255, 3, 46, 64),
              ),
              label: 'Two',
              shape: CircleBorder(),
              onTap: null),
          SpeedDialChild(
              child: Icon(
                Icons.looks_3,
                color: Color.fromARGB(255, 3, 46, 64),
              ),
              label: 'Three',
              shape: CircleBorder(),
              onTap: null),
        ],
      ),
    );
  }
}
