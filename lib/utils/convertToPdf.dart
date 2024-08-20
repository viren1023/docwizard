import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

Future<Map<String, Object>?> _convertToPdf(_selectedFile, _fileName) async {
  if (_selectedFile == null) return null;

  final pdf = pw.Document();
  final String text = await _selectedFile!.readAsString();
  print(text);

  // Split the text into chunks that fit on a single page
  final font = pw.Font.helvetica();
  final fontSize = 12.0;
  final maxLinesPerPage = 64; // Estimate based on font size and page dimensions
  final lines = text.split('\n'); // Split the text into lines
  final pages = <List<String>>[];

  // Group lines into pages
  for (int i = 0; i < lines.length; i += maxLinesPerPage) {
    pages.add(lines.sublist(
        i,
        i + maxLinesPerPage > lines.length
            ? lines.length
            : i + maxLinesPerPage));
  }

  // Add each page to the PDF
  for (var pageLines in pages) {
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: pageLines
                .map((line) => pw.Text(line,
                    style: pw.TextStyle(font: font, fontSize: fontSize)))
                .toList(),
          );
        },
      ),
    );
  }
  final outputDir = await getTemporaryDirectory();
  final outputFile = File('${outputDir.path}/$_fileName.pdf');
  await outputFile.writeAsBytes(await pdf.save());

  File? _pdfFile = outputFile;

  return {
    "_pdfFile": outputFile,
    "_history": {
      'fileName': _fileName!,
      'filePath': _pdfFile.path,
    }
  };
}
