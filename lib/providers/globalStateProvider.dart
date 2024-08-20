import 'dart:io';
import 'package:flutter/material.dart';

class GlobalStateProvider extends ChangeNotifier {
  late File filePath;
  late String fileName;

  void setFilePath({required File newFilePath}) async {
    filePath = newFilePath;
    print(filePath);
    notifyListeners();
  }

  void setFileName({required String newFileName}) async {
    fileName = newFileName;
    print(fileName);
    notifyListeners();
  }
}
