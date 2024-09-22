import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:path/path.dart' as path;
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveAndOpenDocument {
  static Future<void> insert_data(name, path, size, time) async {
    print("in insert_data");
    String url = "http://192.168.0.113/doc_wizard/index.php/save_record";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    print("Token : ${token}");
    size = size.toString();
    time = time.toString();
    // print(token.runtimeType);
    // print(name.runtimeType);
    // print(size.runtimeType);
    // print(path.runtimeType);
    // print(time.runtimeType);

    var res = await http.post(Uri.parse(url), body: {
      "token": token,
      "name": name,
      "path": path,
      "size": size,
      "time": time
    });

    try {
      var jsonResponse = await jsonDecode(res.body);
      print(jsonResponse);
    } catch (e) {
      print(e);
    }
    print("response came");
  }

  static Future<String> saveFileToTempStorage(
      String fileName, Document pdf) async {
    try {
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

  static Future<void> openPdf(final file) async {
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
      await OpenFile.open(path);
      print('open');
    } catch (e) {
      print('Error opening file: $e');
    }
    print("after opening");
  }

  static Future<String> autoNameFile(name) async {
    var i = 1;
    var test_name = name;
    while (true) {
      // var file_name_path='/storage/emulated/0/Download/DocWizard/${name}';
      File file_path =
          File('/storage/emulated/0/Download/DocWizard/${name}.pdf');
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

  static Future<File> savePdf({
    required String name,
    required Document pdf,
  }) async {
    // final sysName = 'converted_${DateTime.now().millisecondsSinceEpoch}.pdf';

    // final root = await createAppFolder();
    // final outputDir = await getApplicationDocumentsDirectory();
    // Directory? downloadsDirectory = await getDownloadsDirectory();
    Directory? downloadsDirectory = await createAppFolder();
    name = await autoNameFile(name);
    final file = File('${downloadsDirectory.path}/${name}.pdf');
    await file.writeAsBytes(await pdf.save());
    print('File saved at: ${file.path}');

    final fileStat = await file.stat();

    final fileName = file.uri.pathSegments.last;
    final filePath = file.path;
    final fileSize = fileStat.size;
    final fileCreationDate = fileStat.changed;

    insert_data(fileName, filePath, fileSize, fileCreationDate);
    return file;
  }

  static Future<Directory> createAppFolder() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      Directory directory;

      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        throw Exception('Failed to get storage directory');
      }
      final appFolder = Directory('${directory.path}/DocWizard');

      if (!await appFolder.exists()) {
        await appFolder.create(recursive: true);
      }
      print('App folder created: ${appFolder.path}');
      return appFolder;
    } else {
      throw Exception('Permission denied to access storage');
    }
  }
}

class SimplePdfApi {
  static Future<Document> generateThumbnail(File file, String name) async {
    final pdf = Document();

    const int maxLinesPerPage = 35;
    final String textData = await file.readAsString();
    try {
      final List<String> lines = textData.split('\n');
      final List<String> pageLines = lines.take(maxLinesPerPage).toList();

      pdf.addPage(
        Page(
          build: (Context context) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: pageLines
                .map((line) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        line.isEmpty ? ' ' : line,
                        style: TextStyle(fontSize: 18),
                      ),
                    ))
                .toList(),
          ),
        ),
      );

      return pdf;
      // return SaveAndOpenDocument.savePdf(pdf: pdf, name: name);
    } catch (e) {
      print('Error generating PDF: $e');
      return Future.error('Failed to generate PDF');
    }
  }

  static Future<Document> generatePdf(File file, String name) async {
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

    const int maxLinesPerPage = 35;
    final String textData = await file.readAsString();
    // try {
    //   final List<String> lines = textData.split('\n');
    //   for (int i = 0; i < lines.length; i += maxLinesPerPage) {
    //     final List<String> pageLines =
    //         lines.skip(i).take(maxLinesPerPage).toList();
    //     pdf.addPage(
    //       Page(
    //         build: (Context context) => Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: pageLines
    //               .map((line) => Text(line, style: TextStyle(fontSize: 18)))
    //               .toList(),
    //         ),
    //       ),
    //     );
    //   }
    final List<String> lines = textData.split('\n');
    for (int i = 0; i < lines.length; i += maxLinesPerPage) {
      final List<String> pageLines =
          lines.skip(i).take(maxLinesPerPage).toList();
      pdf.addPage(
        Page(
          build: (Context context) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: pageLines
                .map((line) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        line.isEmpty ? ' ' : line,
                        style: TextStyle(fontSize: 18),
                      ),
                    ))
                .toList(),
          ),
        ),
      );
    }
    return pdf;
  }
}
