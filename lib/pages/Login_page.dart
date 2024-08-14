import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:doc_wizard/main.dart';
import 'package:doc_wizard/pages/Register_page.dart';

// import 'package:doc_wizard/main.dart';
// import 'package:doc_wizard/pages/Register_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  bool _obscureText = true;
  late List<String> emailList;
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

      List<String> value = [_emailController.text, _passwordController.text];

      bool success = await _checkData(value);

      if (success) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      }
    }
  }

  Future<bool> _checkData(List<String> value) async {
    print(value);
    // print('value = ${value[0]}, emailList = ${emailList}');

    // if (!emailList.contains(value[0])) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Invalid email or password.'),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    //   return false; // Indicate failure
    // }

    String? key = await _getKeyByEmail(value[0]);
    late List<String>? item;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (key != null) {
      item = prefs.getStringList(key);
      if (item?[2] != value[1]) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email or password.'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
      // Use the key for further operations
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password.'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
      // Handle the case where the email is not found
    }

    print('Saving key: ${item}');
    await prefs.setStringList('signInCred', item!);
    return true;
  }

  Future<String?> _getKeyByEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();

    for (String key in keys) {
      // Retrieve the list of strings for the current key
      List<String>? item = prefs.getStringList(key);

      // Check if the list is not null and contains the email
      if (item != null && item.contains(email)) {
        // Assuming email is at index 1, adjust if necessary
        if (item[1] == email) {
          print('Found email $email in key $key');
          return key; // Return the key if the email matches
        }
      }
    }

    return null; // Return null if the email was not found
  }

  Future<void> _initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> allKeys = prefs.getKeys();
    List<String> lst = [];

    print(allKeys);

    for (String key in allKeys) {
      var item = prefs.getStringList(key);
      print('key ${item?[1]}');
      lst.add(item![1]);
    }
    print('lst ${lst}');
    setState(() {
      emailList = lst;
    });
    print('All email ${emailList}');
    await prefs.clear();
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
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(
                                                10)), // Set the desired border radius here
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
