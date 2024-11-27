import 'dart:convert';
import 'package:doc_wizard/utils/saveToken.dart';
import 'package:doc_wizard/utils/snackBar.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:doc_wizard/main.dart';
import 'package:doc_wizard/pages/Login_page.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  bool _isLoading = false;
  bool _obscureText = true;
  final signUpFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // late String ipAddress;

  @override
  void initState() {
    super.initState();
    // _initData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    print('hello');
    if (signUpFormKey.currentState!.validate()) {
      signUpFormKey.currentState!.save();
      print("hello 1");
      setState(() {
        _isLoading = true;
      });
      // String ipAddress = context.read<IPAddressProvider>().ipAddress;

      String url = "http://192.168.0.113/doc_wizard/i/ndex.php/signup";
      // String url = "http://192.168.52.78/doc_wizard/index.php/signup";

      // try {

      print('before passed res');
      print(url);
      var res = await http.post(Uri.parse(url), body: {
        '_name': _nameController.text,
        '_email': _emailController.text,
        '_password': _passwordController.text,
      });
      print('after passed res');
      print(res.statusCode);
      print(res.body);
      var jRes = await jsonDecode(res.body);

      if (res.statusCode == 200) {
        saveToken(jRes['token'], false);
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
      } else {
        print('else');
        setState(() {
          _isLoading = false;
        });
        showCustomSnackBar(context, jRes['message']);
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
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: signUpFormKey,
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: IntrinsicHeight(
                  child: Stack(
                    children: [
                      ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
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
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 40,
                                fontFamily: 'Anta',
                                // fontWeight: FontWeight.w400
                              ),
                            )),
                            const SizedBox(height: 25),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        foregroundColor: const Color.fromARGB(
                                            255, 133, 129, 126),
                                        backgroundColor: const Color.fromARGB(
                                            255, 191, 187, 181),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.horizontal(
                                                    left:
                                                        Radius.circular(10)))),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Login()),
                                      );
                                    },
                                    child: const Text('Sign In'),
                                  ),
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      disabledBackgroundColor:
                                          const Color.fromARGB(
                                              255, 247, 242, 250),
                                      disabledForegroundColor:
                                          const Color.fromARGB(
                                              255, 103, 80, 164),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.horizontal(
                                              right: Radius.circular(10))),
                                      elevation: 0,
                                    ),
                                    onPressed: null,
                                    child: const Text('Sign Up'),
                                    // color: Colors.deepPurple[300],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: 'Name',
                                  prefixIcon: const Icon(Icons.person)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter name';
                                }
                                if (value.length < 3) {
                                  return 'Please enter a valid name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  // focusColor: Colors.deepPurple[100],
                                  fillColor: Colors.red,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: 'Email',
                                  prefixIcon: const Icon(Icons.email)),
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
                            const SizedBox(
                              height: 15,
                            ),
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
                                  return 'Please enter password';
                                }
                                if (value.length < 8) {
                                  return 'Password must be at least 8 character long';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              child: _isLoading
                                  ? ElevatedButton(
                                      onPressed: null,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(),
                                      ))
                                  : ElevatedButton(
                                      onPressed: _submitForm,
                                      child: const Text('Sign Up')),
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
        // ),
      ),
    );
  }
}
