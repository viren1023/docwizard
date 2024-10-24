import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

// CONVERT TXT TO PDF

Future<Document> generatePdfFromTxt(File file, String name, String type) async {
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

  if (type == "file") {
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
  } else if (type == "thumbnail") {
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
  }
  return pdf;
}

Future<Document> generatePdfFromImages(List<File> images, String type) async {
  final pdf = Document();

  if (type == "file") {
    for (var img in images) {
      final image = MemoryImage(img.readAsBytesSync());

      pdf.addPage(
        Page(
          pageFormat: PdfPageFormat.a4,
          build: (Context context) {
            return Center(
              child: Image(image),
            );
          },
        ),
      );
    }
  } else if (type == "thumbnail") {
    final img = images[0]; // Get the first image
    final image = MemoryImage(img.readAsBytesSync());

    pdf.addPage(
      Page(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return Center(
            child: Image(image),
          );
        },
      ),
    );
  }

  return pdf;
}
