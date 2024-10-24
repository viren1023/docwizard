import 'dart:io';
import 'package:doc_wizard/pages/previewFile.dart';
import 'package:doc_wizard/utils/init.dart';
import 'package:doc_wizard/utils/nonConverted.dart';
import 'package:doc_wizard/utils/openFile.dart';
import 'package:doc_wizard/utils/createThumbnail.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:doc_wizard/utils/choseFile.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:doc_wizard/providers/file_type.dart';
// enum FileType { txt, images }

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
    createAppFolder();
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
        print(_files.isEmpty);
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
    // BorderSide BoxPadding = BorderSide(width: 8, color: Color.fromARGB(255, 212, 131, 105));
    BorderSide BoxPadding =
        BorderSide(width: 8, color: Color.fromARGB(255, 3, 46, 64));

    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _files.isEmpty
              ? NonConverted()
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 18.0,
                    mainAxisSpacing: 18.0,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: _files.length,
                  padding: EdgeInsets.all(24),
                  itemBuilder: (context, index) {
                    final file = _files[index];
                    return GestureDetector(
                      onTap: () => openPdf(file),
                      child: Container(
                          // margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border(
                                left: BoxPadding,
                                right: BoxPadding,
                                top: BoxPadding),
                            color: Colors.white,
                          ),
                          child: Column(children: [
                            Expanded(
                              flex: 2,
                              child: FutureBuilder(
                                future: createThumbnail(file.path),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                          width: 0,
                                        )),
                                        color: Colors.white,
                                      ),
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
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 3, 46, 64),
                                ),
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                width: double.infinity,
                                height: double.minPositive,
                                // color: Color.fromARGB(255, 212, 131, 105),
                                child: Text(
                                  file.path.split('/').last,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                            ),
                          ])),
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
              label: 'TXT to PDF',
              shape: CircleBorder(),
              onTap: () async {
                bool result = await pickTextFile(context);
                if (result) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PreviewPage(fileType: FileType.txt)));
                }
              }),
          SpeedDialChild(
              child: Icon(
                Icons.looks_two_rounded,
                color: Color.fromARGB(255, 3, 46, 64),
              ),
              label: 'Images to PDF',
              shape: CircleBorder(),
              onTap: () async {
                List<File>? images = await pickImages();
                if (images!.isNotEmpty) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PreviewPage(
                              fileType: FileType.images, images: images)));
                }
              }),
        ],
      ),
    );
  }
}
