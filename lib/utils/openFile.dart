import 'package:open_filex/open_filex.dart';

Future<void> _openPdf(path, _pdfFile) async {
  if (_pdfFile != null) {
    await OpenFilex.open(_pdfFile!.path);
  }
}
