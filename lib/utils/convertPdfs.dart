// import 'package:doc_wizard/utils/downloadFile.dart';
// import 'package:flutter/material.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
// import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class SaveAndOpenDocument {
  static Future<void> openPdf(File file) async {
    final path = file.path;
    final exists = await file.exists();
    if (exists) {
      print('File exists and is at: $path');
    } else {
      print('File does not exist at: $path');
    }
    print("in open ${file.path}");
    // await OpenFile.open(path);
    try {
      final result = await OpenFile.open(path);
      print('open');
    } catch (e) {
      print('Error opening file: $e');
    }
    print("after opening");
    // final result = await OpenFile.open(file);
    // if (result == true) {
    //   print("PDF opened successfully");
    // } else {
    //   print("Failed to open PDF: ${result.message}");
    // }
  }

  static Future<Directory?> getDownloadsDirectory() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      if (Platform.isAndroid) {
        // On Android, the download folder path is usually '/storage/emulated/0/Download'
        Directory directory = Directory('/storage/emulated/0/Download');
        if (await directory.exists()) {
          return directory;
        }
      } else if (Platform.isIOS) {
        // On iOS, you might want to use the documents directory instead
        return await getApplicationDocumentsDirectory();
      }
      return null;
    }
  }

  static Future<File> savePdf({
    required String name,
    required Document pdf,
  }) async {
    final sysName = 'converted_${DateTime.now().millisecondsSinceEpoch}.pdf';

    // final root = await createAppFolder();
    // final outputDir = await getApplicationDocumentsDirectory();
    Directory? downloadsDirectory = await getDownloadsDirectory();
    final file = File('${downloadsDirectory?.path}/$sysName');
    await file.writeAsBytes(await pdf.save());
    print('File saved at: ${file.path}');
    return file;
  }

  static Future<String> createAppFolder() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    // final directory = await getApplicationDocumentsDirectory();

    if (directory == null) {
      throw Exception('Failed to get storage directory');
    }
    final appFolder = Directory('${directory.path}/converted_files');

    if (!await appFolder.exists()) {
      await appFolder.create(recursive: true);
    }
    print(appFolder.path);
    return appFolder.path;
  }
}

class SimplePdfApi {
  static Future<File> generatePdf(File file, String name) async {
    final pdf = Document();

    // try {
    // final String textData = await file.readAsString();
    // pdf.addPage(MultiPage(
    //     pageFormat: PdfPageFormat.a4,
    //     build: (context) => [
    //           Paragraph(
    //             text: textData,
    //           )
    //         ]));

    const int maxLinesPerPage = 64;
    final String textData = await file.readAsString();
    try {
      final List<String> lines = textData.split('\n');
      for (int i = 0; i < lines.length; i += maxLinesPerPage) {
        final List<String> pageLines =
        lines.skip(i).take(maxLinesPerPage).toList();
        pdf.addPage(
          Page(
            build: (Context context) => Column(
              children: pageLines.map((line) => Text(line)).toList(),
            ),
          ),
        );
      }

      return SaveAndOpenDocument.savePdf(pdf: pdf, name: name);
    } catch (e) {
      print('Error generating PDF: $e');
      return Future.error('Failed to generate PDF');
    }
  }
}

//  /storage/emulated/0/Android/data/com.example.doc_wizard/files/converted_1725182262391.pdf



// // import 'package:doc_wizard/utils/downloadFile.dart';
// // import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// // import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class SaveAndOpenDocument {
//   static Future<void> openPdf(File file) async {
//
//       final path = file.path;
//       print("in open ${file.path}");
//       final result = await OpenFile.open(path);
//       // if (result.type == ResultType.done) {
//       //   print("PDF opened successfully");
//       // } else {
//       //   print("Failed to open PDF: ${result.message}");
//       // }
//       print("after opening");
//   }
//
//   static Future<Directory?> getDownloadsDirectory() async {
//     if (await Permission.storage
//         .request()
//         .isGranted ||
//         await Permission.manageExternalStorage
//             .request()
//             .isGranted) {
//       if (Platform.isAndroid) {
//         // On Android, the download folder path is usually '/storage/emulated/0/Download'
//         Directory directory = Directory('/storage/emulated/0/Download');
//         if (await directory.exists()) {
//           return directory;
//         }
//       } else if (Platform.isIOS) {
//         // On iOS, you might want to use the documents directory instead
//         return await getApplicationDocumentsDirectory();
//       }
//     }
//     return null;
//   }
//
//   static Future<File?> savePdf({
//     required String name,
//     required Document pdf,
//   }) async {
//
//       final sysName = 'converted_${DateTime
//           .now()
//           .millisecondsSinceEpoch}.pdf';
//
//       // final root = await createAppFolder();
//       // final outputDir = await getApplicationDocumentsDirectory();
//       Directory? downloadsDirectory = await getDownloadsDirectory();
//       final file = File('${downloadsDirectory?.path}/$sysName');
//       await file.writeAsBytes(await pdf.save());
//       print('File saved at: ${file.path}');
//       return file;
//     }
//   }
//
// //   static Future<String> createAppFolder() async {
// //     final directory = Platform.isAndroid
// //         ? await getExternalStorageDirectory()
// //         : await getApplicationDocumentsDirectory();
// //
// //     // final directory = await getApplicationDocumentsDirectory();
// //
// //     if (directory == null) {
// //       throw Exception('Failed to get storage directory');
// //     }
// //     final appFolder = Directory('${directory.path}/converted_files');
// //
// //     if (!await appFolder.exists()) {
// //       await appFolder.create(recursive: true);
// //     }
// //     print(appFolder.path);
// //     return appFolder.path;
// // }
//
// class SimplePdfApi {
//   static Future<File?> generatePdf(File file, String name) async {
//     final pdf = Document();
//
//     // try {
//     // final String textData = await file.readAsString();
//     // pdf.addPage(MultiPage(
//     //     pageFormat: PdfPageFormat.a4,
//     //     build: (context) => [
//     //           Paragraph(
//     //             text: textData,
//     //           )
//     //         ]));
//
//     const int maxLinesPerPage = 64;
//     final String textData = await file.readAsString();
//     try {
//       final List<String> lines = textData.split('\n');
//       for (int i = 0; i < lines.length; i += maxLinesPerPage) {
//         final List<String> pageLines =
//             lines.skip(i).take(maxLinesPerPage).toList();
//         pdf.addPage(
//           Page(
//             build: (Context context) => Column(
//               children: pageLines.map((line) => Text(line)).toList(),
//             ),
//           ),
//         );
//       }
//
//       return SaveAndOpenDocument.savePdf(pdf: pdf, name: name);
//     } catch (e) {
//       print('Error generating PDF: $e');
//       return Future.error('Failed to generate PDF');
//     }
//   }
// }
//
// //  /storage/emulated/0/Android/data/com.example.doc_wizard/files/converted_1725182262391.pdf
