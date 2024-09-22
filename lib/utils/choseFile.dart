import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

import '../providers/globalStateProvider.dart';

Future<bool> pickTextFile(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File selectedFile = File(result.files.single.path!);
    String fileNameWithExtension = result.files.single.name;

    String fileNameWithoutExtension = fileNameWithExtension.substring(0, fileNameWithExtension.lastIndexOf('.'));

    context.read<GlobalStateProvider>().setFilePath(newFilePath: selectedFile);
    context.read<GlobalStateProvider>().setFileName(newFileName: fileNameWithoutExtension);

    return true;
  }
  return false;
}
