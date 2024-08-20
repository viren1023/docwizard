import 'dart:io';
import 'package:file_picker/file_picker.dart';

Future<bool?> _savePdfToDirectory(_pdfFile) async {
  if (_pdfFile == null) return null;

  String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

  if (selectedDirectory != null) {
    final fileName = 'converted_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final destinationFile = File('$selectedDirectory/$fileName');

    await _pdfFile!.copy(destinationFile.path);

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text('PDF saved to $selectedDirectory'),
    // ));
    return true; // success
  }
  return null;
}
