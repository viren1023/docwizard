import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

import '../providers/globalStateProvider.dart';

Future<bool> pickTextFile(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['txt'],
  );

  if (result != null) {
    File selectedFile = File(result.files.single.path!);
    String fileName = result.files.single.name;

    context.read<GlobalStateProvider>().setFilePath(newFilePath: selectedFile);
    context.read<GlobalStateProvider>().setFileName(newFileName: fileName);

    return true;
  }
  return false;
}
