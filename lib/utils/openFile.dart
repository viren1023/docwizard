import 'package:open_file/open_file.dart';


Future<void> openPdf(final file) async {
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
