import 'package:doc_wizard/main.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:doc_wizard/utils/snackBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  double _rating = 3;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _feedbackController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_rating > 0) {
        setState(() {
          _isLoading = true; // Indicate loading state
        });

        SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');

        // Home
        String url =
            "http://192.168.0.113/doc_wizard/index.php/submit_feedback";
        // String url = "http://192.168.52.78/doc_wizard/index.php/submit_feedback";

        try {
          DateTime now = DateTime.now();
          String formattedDate = DateFormat('dd-MM-yy').format(now);

          print("token: $token");
          print("name: ${_nameController.text}");
          print("'email': ${_emailController.text}");
          print("'feedback': ${_feedbackController.text}");
          print("'no_of_star': ${_rating.toString()}");
          print("'date' : ${formattedDate.toString()}");

          var res = await http.post(Uri.parse(url), body: {
            'token': token,
            'name': _nameController.text,
            'email': _emailController.text,
            'feedback': _feedbackController.text,
            'no_of_star': _rating.toString(),
            'date': formattedDate,
          });

          // 'date' : formattedDate,
          var jsonResponse = jsonDecode(res.body);
          print(jsonResponse);
          setState(() {
            _isLoading = false; // Reset loading state
          });

          if (res.statusCode == 200) {
            _showSuccessDialog();
          } else {
            showCustomSnackBar(context, jsonResponse['message']);
          }
        } catch (e) {
          setState(() {
            _isLoading = false;
          });
          print(e);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please provide a rating.')),
        );
      }
    }
  }

  void _showSuccessDialog() {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: const Text('Thanks for rating us!'),
      actions: [
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 3, 106, 115),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MainPage()));
            },
            child: const Text('OK'),
          ),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FeedBack'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'FeedBack From',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 50),
                const Text('Rate Our App', style: TextStyle(fontSize: 18)),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  autocorrect: true,
                  decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  autocorrect: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Email ID',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _feedbackController,
                  autocorrect: true,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 25,
                  decoration: InputDecoration(
                      labelText: 'FeedBack Message',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your feedback';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 3, 106, 115),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
