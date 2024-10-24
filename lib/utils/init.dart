import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// USED TO CREATE FOLDER OF APP IF NOT CREATED (/dowload/doc_wizard)

Future<Directory> createAppFolder() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      Directory directory;

      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
      } else {
        directory = await getApplicationDocumentsDirectory();
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