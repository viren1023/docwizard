import 'package:pdfx/pdfx.dart';
import 'package:flutter/material.dart';

Future<Widget> createThumbnail(String filePath) async {
  PdfDocument? _pdfDocument;
  PdfPageImage? _pdfPageImage;

  try {
    _pdfDocument = await PdfDocument.openFile(filePath);
    final PdfPage pdfPage = await _pdfDocument!.getPage(1);

    _pdfPageImage = await pdfPage.render(
      width: 1080,
      height: 2340,
    );
    await pdfPage.close();

    return Image.memory(
      _pdfPageImage!.bytes,
      // fit: BoxFit.values[3],
      // fit: BoxFit.values[0],
      // fit: BoxFit.contain,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
      width: 1080,
      height: 2340,
    );
  } catch (e) {
    return Text('Failed to load PDF');
  }
}
