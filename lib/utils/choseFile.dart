import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/globalStateProvider.dart';

Future<bool> pickTextFile(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ["txt"],
  );

  if (result != null) {
    File selectedFile = File(result.files.single.path!);
    String fileNameWithExtension = result.files.single.name;

    String fileNameWithoutExtension = fileNameWithExtension.substring(
        0, fileNameWithExtension.lastIndexOf('.'));

    context.read<GlobalStateProvider>().setFilePath(newFilePath: selectedFile);
    context
        .read<GlobalStateProvider>()
        .setFileName(newFileName: fileNameWithoutExtension);

    return true;
  }
  return false;
}

// Future<List<File>> pickImages() async {
//   final picker = ImagePicker();
//   List<File> image = [];
//   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//   if (pickedFile != null) {
//     image.add(File(pickedFile.path));
//     print('Image added successfully');
//     // return ;
//   } else {
//     print('No image selected');
//     // return false;
//   }
//   return image;
// }

Future<List<File>?> pickImages() async {
  List<File>? selectedImages = await FilePicker.platform
      .pickFiles(
    type: FileType.image,
    allowMultiple: true,
  )
      .then((result) {
    if (result != null) {
      return result.paths.map((path) => File(path!)).toList();
    }
    // return null;
  });
  return selectedImages;
}
