import 'dart:ui';
import 'dart:convert';
import 'package:doc_wizard/utils/saveToken.dart';
import 'package:doc_wizard/utils/snackBar.dart';
import 'package:flutter/material.dart';

import 'package:doc_wizard/main.dart';
import 'package:doc_wizard/pages/Register_page.dart';
import 'package:http/http.dart' as http;

// import 'package:doc_wizard/main.dart';
// import 'package:doc_wizard/pages/Register_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  bool _obscureText = true;
  final signInFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _initData();
    // _loadKeys();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (signInFormKey.currentState!.validate()) {
      signInFormKey.currentState!.save();

      String url = "http://192.168.0.113/doc_wizard/index.php/signin";
      // String url = "http://192.168.0.122/doc_wizard/index.php/signin";

      print('before passed res');

      var res = await http.post(Uri.parse(url), body: {
        "_email": _emailController.text,
        "_password": _passwordController.text,
      });
      print('after passed res');
      var jsonResponse = await jsonDecode(res.body);

      print(res.statusCode);
      print(res.body);

      if (res.statusCode == 200) {
        saveToken(jsonResponse['token']);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
      } else {
        showCustomSnackBar(context, jsonResponse['message']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background1.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: signInFormKey,
              child: FractionallySizedBox(
                widthFactor: 0.8,
                // heightFactor: 0.55,
                child: IntrinsicHeight(
                  child: Stack(
                    children: [
                      ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.transparent,
                              color: Colors.white
                                  .withOpacity(0.5), // Adjust opacity as needed
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Center(
                                child: Text(
                              'Sign In',
                              style: TextStyle(
                                decorationColor: Color(0xFF005F73),
                                fontSize: 40,
                                fontFamily: 'Anta',
                                // fontWeight: FontWeight.w500
                              ),
                            )),
                            const SizedBox(height: 25),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: null,
                                    // color: Colors.deepPurple[300],
                                    style: ElevatedButton.styleFrom(
                                      disabledBackgroundColor:
                                          const Color.fromARGB(
                                              255, 247, 242, 250),
                                      disabledForegroundColor:
                                          const Color.fromARGB(
                                              255, 103, 80, 164),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(10)),
                                      ),
                                    ),
                                    child: const Text('Sign In'),
                                  ),
                                ),
                                // SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      foregroundColor: const Color.fromARGB(
                                          255, 133, 129, 126),
                                      backgroundColor: const Color.fromARGB(
                                          255, 191, 187, 181),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.horizontal(
                                            right: Radius.circular(
                                                10)), // Set the desired border radius here
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Register()),
                                      );
                                    },
                                    child: const Text('Sign Up'),
                                    // color: Colors.deepPurple[300],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                fillColor: Colors.red,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                prefixIcon: const Icon(Icons.email),
                                labelText: 'E-mail',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter e-mail';
                                }
                                String pattern = r'^[^@]+@[^@]+\.[^@]+';
                                RegExp regex = RegExp(pattern);
                                if (!regex.hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.password),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                              obscureText: _obscureText,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 8) {
                                  return 'Password must be at least 8 characters long';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: _submitForm,
                                  child: const Text('Sign In')),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
