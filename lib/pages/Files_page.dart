import 'dart:convert';
import 'package:doc_wizard/utils/nonConverted.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Files extends StatefulWidget {
  const Files({super.key});

  @override
  State<Files> createState() => _Files();
}

class _Files extends State<Files> {
  late int lengthOfData;
  late var file_name;
  late var file_path;
  late var file_size;
  late var file_date;
  bool isLoading = true;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    print("helo");
    String url = "http://192.168.0.113/doc_wizard/index.php/file_history";
    // String url = "http://192.168.20.78/doc_wizard/index.php/file_history";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    print(token);
    var res = await http.post(Uri.parse(url), body: {
      "token": token,
    });

    var result = await jsonDecode(res.body);
    print(result);
    print('file_name ${result['file_name']}');
    setState(() {
      if (result['file_name'] == null) {
        lengthOfData = 0;
      } else {
        lengthOfData = result['file_name'].length;
        file_name = result['file_name'];
        file_path = result['file_path'];
        file_date = result['time_date'];
        file_size = result['file_size'];
      }

      isLoading = false;
    });
    print(lengthOfData);
    print(result);
  }

  String formatFileSize(String sizeString) {
    // Regular expression to extract numeric part from the size string
    final RegExp regex = RegExp(r'(\d+)');
    final match = regex.firstMatch(sizeString);

    if (match == null) {
      throw ArgumentError('Invalid size string');
    }

    int bytes = int.parse(match.group(0)!);

    // Convert bytes to the appropriate unit
    if (bytes < 1024) {
      return '$bytes bytes';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
    }
  }

  String formatDate(String dateTimeString) {
    final DateFormat inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    DateTime dateTime = inputFormat.parse(dateTimeString);
    final DateFormat outputFormat = DateFormat('dd MMM yy');
    return outputFormat.format(dateTime);
  }

  List<String> formatDateTime(String dateTimeString) {
    final DateFormat inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    DateTime dateTime = inputFormat.parse(dateTimeString);

    final DateFormat dateFormat = DateFormat('dd MMM yy');
    final DateFormat timeFormat = DateFormat('HH:mm');

    String formattedDate = dateFormat.format(dateTime);
    String formattedTime = timeFormat.format(dateTime);

    return [formattedDate, formattedTime];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : lengthOfData == 0
              ? NonConverted()
              : ListView.builder(
                  itemCount: lengthOfData,
                  // reverse: true,
                  itemBuilder: (context, index) {
                    var current_File_name = file_name[index];
                    var current_File_path = file_path[index];
                    var current_File_size = formatFileSize(file_size[index]);
                    var current_File_date = formatDateTime(file_date[index]);
                    return ListTile(
                        leading: Icon(Icons.insert_drive_file),
                        title: Text(current_File_name),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(current_File_date[0],
                                style: TextStyle(
                                  fontSize: 12,
                                )),
                            Text(current_File_date[1],
                                style: TextStyle(fontSize: 10)),
                          ],
                        ),
                        subtitle: Text(
                          current_File_size,
                          style: TextStyle(fontSize: 12),
                        ),
                        // subtitle: Text(
                        //     'Path: ${current_File_path}\nSize: ${current_File_size}\nDate: ${current_File_date}'),
                        // isThreeLine: true,
                        onTap: null
                        //  {
                        // Handle tile tap
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text('Clicked on ${file.name}')),
                        // );
                        // },
                        );
                  },
                ),
      //   body: Center(
      // child: Opacity(
      //   opacity: 0.3,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       CircleAvatar(
      //         radius: 100,
      //         child: Image.asset('assets/images/app_logo.png'),
      //       ),
      //       SizedBox(height: 10),
      //       Text(
      //         'No Files yet',
      //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      //       )
      //     ],
      //   ),
      // ),
      // )
    );
  }
}
