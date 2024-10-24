import 'dart:io';
import 'package:doc_wizard/main.dart';
import 'package:doc_wizard/utils/createThumbnail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doc_wizard/utils/openFile.dart';
import 'package:doc_wizard/providers/globalStateProvider.dart';
import 'package:doc_wizard/utils/convertFile.dart';
import 'package:doc_wizard/utils/saveFile.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:doc_wizard/providers/file_type.dart';

// enum FileType { txt, images }

class PreviewPage extends StatefulWidget {
  final FileType fileType;
  final List<File> images;

  const PreviewPage({
    super.key,
    required this.fileType,
    this.images = const [], // Default value set to an empty list
  });

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  late File filePath;
  String? tempPdfPath = '';
  String fileName = '';
  var pdf;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  @override
  void dispose() {
    filePath = File('');
    tempPdfPath = '';
    fileName = '';
    pdf = null;

    super.dispose();
  }

  Future<void> _loadPdf() async {
    if (widget.fileType == FileType.txt) {
      filePath = context.read<GlobalStateProvider>().filePath;
      fileName = context.read<GlobalStateProvider>().fileName;
      pdf = await generatePdfFromTxt(filePath, fileName, 'thumbnail');
    } else if (widget.fileType == FileType.images) {
      pdf = await generatePdfFromImages(widget.images, 'thumbnail');
    }

    // function to use if its a txt file
    // pdf = await generatePdfFromTxt(filePath, fileName, 'thumbnail');
    // function to use if its images
    // pdf = await generatePdfFromImages(filePath, fileName, 'thumbnail');

    tempPdfPath = await saveFileToTempStorage(pdf);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("Preview File")),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color.fromARGB(112, 146, 141, 133),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IntrinsicHeight(
              child: Container(
                  margin: EdgeInsets.all(16),
                  // width: 350,
                  height: screenHeight * 0.6,
                  width: screenWidth * 0.65,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  // alignment: Alignment.topCenter,
                  child: tempPdfPath == ''
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 3, 46, 64),
                          ),
                        )
                      : FutureBuilder(
                          future: createThumbnail(tempPdfPath!),
                          builder: (BuildContext context,
                              AsyncSnapshot<Widget> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Color.fromARGB(255, 3, 46, 64),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return snapshot.data!;
                            }
                          },
                        )),
            ),
            // Text(filePath.path),
            // Text(fileName),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                // TODO
                if (await Permission.manageExternalStorage
                    .request()
                    .isGranted) {
                } else {}

                var newPdf;
                if (widget.fileType == FileType.txt) {
                  newPdf = await generatePdfFromTxt(filePath, fileName, 'file');
                } else if (widget.fileType == FileType.images) {
                  newPdf = await generatePdfFromImages(widget.images, 'file');
                }
                // setState(() {
                //   pdf = newPdf;
                // });
                var newPath = await savePdf(
                    name: fileName, pdf: newPdf, context: context);

                final snackBar = SnackBar(
                  content: const Text('Saved'),
                  action: SnackBarAction(
                    label: 'Open',
                    onPressed: () async {
                      await openPdf(newPath);
                    },
                  ),
                  duration: const Duration(seconds: 3),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                    (Route) => false);
              },
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 212, 131, 105)),
              child: const Text(
                "Download",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
