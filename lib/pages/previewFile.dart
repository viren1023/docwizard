import 'dart:io';
import 'package:doc_wizard/utils/createThumbnail.dart';
import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/widgets.dart';
import 'package:provider/provider.dart';
import 'package:doc_wizard/utils/convertPdfs.dart';
import 'package:doc_wizard/providers/globalStateProvider.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  late File filePath;
  String? tempPdfPath = '';
  late String fileName;
  var pdf;

  @override
  void initState() {
    super.initState();

    filePath = context.read<GlobalStateProvider>().filePath;
    fileName = context.read<GlobalStateProvider>().fileName;

    _loadPdf();
  }

  Future<void> _loadPdf() async {
    pdf = await SimplePdfApi.generateThumbnail(filePath, fileName);
    tempPdfPath =
        await SaveAndOpenDocument.saveFileToTempStorage(fileName, pdf);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Confirm Download")),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color.fromARGB(112, 146, 141, 133),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
                margin: EdgeInsets.all(16),
                width: 275,
                height: 500,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                // alignment: Alignment.topCenter,
                child: tempPdfPath == ''
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.amber,
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
                                color: Colors.red,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return snapshot.data!;
                          }
                        },
                      )),
            // Text(filePath.path),
            // Text(fileName),
            SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: () async {
                var newPdf = await SimplePdfApi.generatePdf(filePath, fileName);
                setState(() {
                  pdf = newPdf;
                });
                var newPath =
                    await SaveAndOpenDocument.savePdf(name: fileName, pdf: pdf);
                final snackBar = SnackBar(
                  content: const Text('Saved'),
                  action: SnackBarAction(
                    label: 'Open',
                    onPressed: () async {
                      await SaveAndOpenDocument.openPdf(newPath);
                    },
                  ),
                  duration: const Duration(seconds: 5),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 212, 131, 105)),
              child: const Text("Download"),
            ),
          ],
        ),
      ),
    );
  }
}
