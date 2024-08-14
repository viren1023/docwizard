import 'package:flutter/material.dart';
//ignore_for_file:prefer_const_constructors

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _About();
}

class _About extends State<About> {
  SizedBox textPadding = SizedBox(height: 15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'About App',
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                      TextSpan(
                        text: 'Welcome to DocWizard\n\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      TextSpan(
                        text:
                            'At DocWizard, we are dedicated to simplifying and enhancing the way you work with text and PDF files. Our flagship product, DocWizard, is designed to provide an easy and efficient solution for converting text files into high-quality PDFs, catering to both personal and professional needs.\n\n',
                      ),
                      TextSpan(
                        text: 'Our Mission\n\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      TextSpan(
                        text:
                            'Our mission is to deliver user-friendly, reliable, and innovative tools that make digital document management straightforward and accessible. We strive to empower users by offering solutions that save time, improve productivity, and enhance the overall user experience.\n\n',
                      ),
                      TextSpan(
                        text: 'Our Team\n\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      TextSpan(
                        text:
                            'DocWizard is composed of a passionate team of developers, designers, and customer support professionals who are committed to excellence. We work tirelessly to ensure that DocWizard meets the highest standards of quality and performance.\n\n',
                      ),
                      TextSpan(
                        text: 'What We Offer\n\n',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'High-Quality Conversions: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          TextSpan(
                            text:
                                'Our app ensures accurate and professional conversion of text files into PDFs.\n\n',
                          ),
                        ],
                      ),
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'User-Centric Design: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          TextSpan(
                            text:
                                'We prioritize ease of use and functionality, making our app intuitive and efficient.\n\n',
                          ),
                        ],
                      ),
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Continuous Improvement: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          TextSpan(
                            text:
                                'We regularly update DocWizard to incorporate new features, improve performance, and address user feedback.\n\n',
                          ),
                        ],
                      ),
                      TextSpan(
                        text:
                            'We value our users and are here to assist you. If you have any questions, feedback, or need support, please feel free to reach out to us at 98572638273.\n\n',
                      ),
                      TextSpan(
                        text:
                            'Thank you for choosing DocWizard. We look forward to helping you with your document conversion needs!',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50)
            ],
          )),
        ));
  }
}
