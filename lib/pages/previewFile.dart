import 'dart:io';
import 'package:flutter/material.dart';

class PreView extends StatefulWidget {
  const PreView({super.key});

  @override
  State<PreView> createState() => _PreViewState();
}

class _PreViewState extends State<PreView> {
  Widget _buildFilePreview() {
    if (_selectedFile == null) {
      return Text('No file selected');
    }

    String filePath = _selectedFile!.path;
    String fileExtension = filePath.split('.').last.toLowerCase();

    if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
      // Preview for image files
      return Image.file(
        _selectedFile!,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      );
    } else if (['txt'].contains(fileExtension)) {
      // Preview for text files
      return FutureBuilder<String>(
        future: _selectedFile!.readAsString(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Text(
              snapshot.data!,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      );
    } else {
      // For other file types, show a generic icon or message
      return Icon(Icons.insert_drive_file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Convert File'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text('Select File'),
            ),
            SizedBox(height: 20),
            _buildFilePreview(),
          ],
        ),
      ),
    );
  }
}
