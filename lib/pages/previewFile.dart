// import 'package:doc_wizard/main.dart';
// import 'package:doc_wizard/utils/convertToPdf.dart';
// import 'package:doc_wizard/utils/downloadFile.dart';
// import 'package:doc_wizard/utils/snackBar.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:doc_wizard/utils/convertPdfs.dart';
import 'package:doc_wizard/providers/globalStateProvider.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Confirm Download")),
      body: Column(
        children: [
          const Placeholder(),
          Text('${context.read<GlobalStateProvider>().filePath}'),
          Text(context.read<GlobalStateProvider>().fileName),
          TextButton(
            onPressed: () async {
              var filePath = context.read<GlobalStateProvider>().filePath;
              var fileName = context.read<GlobalStateProvider>().fileName;

              var l1 = fileName.split('.');
              var file = await SimplePdfApi.generatePdf(filePath, l1[0]);
              final snackBar = SnackBar(
                content: const Text('Saved'),
                action: SnackBarAction(
                  label: 'Open',
                  onPressed: () async {
                    await SaveAndOpenDocument.openPdf(file!);
                  },
                ),
                duration: const Duration(seconds: 5),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              await SaveAndOpenDocument.openPdf(file!);
            },
            style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 212, 131, 105)),
            child: const Text("Download"),
          ),
          ElevatedButton(
            onPressed: () async {
              final appDocDir = await getApplicationDocumentsDirectory();
              final directory = Directory(appDocDir.path);

              // List all files and directories in the path
              List<FileSystemEntity> entities = directory.listSync();

              // Filter only files (not directories)
              List<File> files = entities.whereType<File>().toList();

              // Print file paths
              for (var file in files) {
                print(file.path);
              }

              // Optionally show the paths in the app's UI
              String filePaths = files.map((file) => file.path).join('\n');
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Files in Directory'),
                    content: SingleChildScrollView(child: Text(filePaths)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('List Files'),
          ),
        ],
      ),
    );
  }
}
