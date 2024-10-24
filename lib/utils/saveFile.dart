import 'dart:io';
import 'package:doc_wizard/utils/generateName.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import "package:doc_wizard/utils/init.dart";
import "package:doc_wizard/utils/http.dart";

// USED TO SAVE FILE TH THE DEFAULT FOLDER (/download/doc_wizard)

Future<File> savePdf(
    {required String name,
    required Document pdf,
    required BuildContext context}) async {
  Directory? downloadsDirectory = await createAppFolder();

  if (name.isEmpty) name = generatePdfNames();

  name = await autoNameFile(name);
  final file = File('${downloadsDirectory.path}/${name}.pdf');
  await file.writeAsBytes(await pdf.save());
  print('File saved at: ${file.path}');

  final fileStat = await file.stat();

  final fileName = file.uri.pathSegments.last;
  final filePath = file.path;
  final fileSize = fileStat.size;
  final fileCreationDate = fileStat.changed;

  insert_data(context, fileName, filePath, fileSize, fileCreationDate);
  return file;
}

// TEMPORARY CONVERT A FILE USED IN PREVIEW PAGE

Future<String> saveFileToTempStorage(Document pdf) async {
  try {
    String fileName = generatePdfNames();
    final Directory tempDir = await getTemporaryDirectory();

    final String filePath = '${tempDir.path}/$fileName';
    final File tempFile = File(filePath);
    await tempFile.writeAsBytes(await pdf.save());

    print('File saved to temporary storage: $filePath');
    return filePath;
  } catch (e) {
    throw Exception('Failed to save file to temporary storage: $e');
  }
}

// USED FOR AUTO NAMING SAME FILES
Future<String> autoNameFile(name) async {
  var i = 1;
  var test_name = name;
  while (true) {
    // var file_name_path='/storage/emulated/0/Download/DocWizard/${name}';
    File file_path = File('/storage/emulated/0/Download/DocWizard/${name}.pdf');
    final exist = await file_path.exists();
    if (exist) {
      name = test_name;
      name = '${name}(${i})';
      i++;
    } else {
      name = name;
      break;
    }
  }
  return name;
}
