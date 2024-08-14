import 'package:flutter/material.dart';

class TNC extends StatefulWidget {
  const TNC({super.key});

  @override
  State<TNC> createState() => _TNCState();
}

class _TNCState extends State<TNC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms & Conditions'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Introduction',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(
                    text: '1. Overview\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'Welcome to DocWizard, a mobile application designed to convert plain text (TXT) files into Portable Document Format (PDF) files. DocWizard is developed by DocWizard, and our goal is to provide a user-friendly and efficient solution for managing and converting text documents.\n\n',
                  ),
                  TextSpan(
                    text: '2. Purpose of the App\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'DocWizard allows users to transform text files into professionally formatted PDF documents. This conversion tool is ideal for individuals and businesses who need to prepare text files for printing, sharing, or archiving in a standardized PDF format.\n\n',
                  ),
                  TextSpan(
                    text: '3. Acceptance of Terms\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'By accessing or using DocWizard, you agree to comply with and be bound by these Terms & Conditions. If you do not agree to these terms, please do not use the app. Your continued use of DocWizard signifies your acceptance of these terms.\n\n',
                  ),
                  TextSpan(
                    text: '4. Changes to Terms\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'We reserve the right to modify these Terms & Conditions at any time. Any changes will be posted on this page with an updated effective date. Your continued use of the app after any changes constitutes your acceptance of the new terms.\n\n',
                  ),
                  TextSpan(
                    text: '5. Contact Information\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'If you have any questions about these Terms & Conditions or need support, please contact us at [Contact Email] or visit our website [Website URL] for more information.\n\n',
                  ),
                ],
              ),
            ),
            Text('Intellectual Property',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(
                    text: '1. Ownership of the App\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'DocWizard and all its associated components, including but not limited to the software, source code, algorithms, designs, graphics, and other materials, are owned by DocWizard or its licensors. All intellectual property rights in DocWizard are expressly reserved.\n\n',
                  ),
                  TextSpan(
                    text: '2. Trademarks\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'The name “DocWizard” and any other trademarks, service marks, logos, or branding elements associated with DocWizard are the property of DocWizard or its licensors. Users are not granted any rights or licenses to use these trademarks without the prior written consent of DocWizard.\n\n',
                  ),
                  TextSpan(
                    text: '3. User Content\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'Users retain ownership of any content they upload to DocWizard. However, by uploading content to the app, users grant DocWizard a non-exclusive, royalty-free, worldwide license to use, store, process, and display the content solely for the purpose of providing the conversion services. This license allows DocWizard to perform necessary operations to facilitate the conversion and delivery of the requested services.\n\n',
                  ),
                  TextSpan(
                    text: '4. Restrictions on Use\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'Users may not:\n\nReproduce, duplicate, copy, sell, resell, or exploit any portion of DocWizard without express written permission from DocWizard.\n\nModify, reverse engineer, decompile, disassemble, or otherwise attempt to derive the source code of DocWizard.\n\nCreate derivative works based on DocWizard or any associated intellectual property.\n\n',
                  ),
                  TextSpan(
                    text: '5. User Feedback\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'Any feedback, suggestions, or ideas provided by users regarding DocWizard are considered non-confidential and may be used by DocWizard without any obligation to compensate the user or acknowledge their contribution.\n\n',
                  ),
                  TextSpan(
                    text: '6. No Transfer of Rights\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'Nothing in these Terms & Conditions shall be construed as granting any rights to users beyond those expressly granted herein. Users do not acquire any ownership rights to DocWizard or its intellectual property by using the app.\n\n',
                  ),
                ],
              ),
            ),
            Text('Privacy and Data Collection',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(
                    text: '1. Data Collection\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'When using DocWizard, we collect certain types of data to provide and improve our services. This data may include:\n\nPersonal Information: Information that identifies you personally, such as your name, email address, and payment information (if applicable).\n\nUsage Data: Information about how you use DocWizard, including your IP address, device type, operating system, and app interactions.\n\nContent Data: The text files you upload for conversion, which are processed to generate PDF documents.\n\n',
                  ),
                  TextSpan(
                    text: '2. Use of Data\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'We use the collected data for the following purposes:\n\nTo Provide and Improve Services: To deliver the conversion services, ensure proper functioning, and enhance user experience.\n\nTo Communicate: To respond to inquiries, provide customer support, and send important updates or notifications related to DocWizard.\n\nTo Process Payments: If applicable, to manage and process subscription fees or purchases.\n\nTo Analyze and Improve: To understand how users interact with DocWizard and to identify areas for improvement.\n\n',
                  ),
                  TextSpan(
                    text: '3. Data Storage and Security\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'Data Retention: We retain your data only for as long as necessary to provide the services, comply with legal obligations, or for other legitimate business purposes. Data may be stored for a limited time and then securely deleted.\n\nSecurity Measures: We implement appropriate technical and organizational measures to protect your data from unauthorized access, disclosure, alteration, or destruction. However, no system can guarantee complete security, and we cannot be held liable for any breaches of security.\n\n',
                  ),
                  TextSpan(
                    text: '4. Sharing of Data\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'We do not sell, rent, or trade your personal data. We may share your data in the following circumstances:\n\nWith Service Providers: We may share data with third-party service providers who perform services on our behalf, such as payment processors or cloud storage providers. These third parties are bound by confidentiality agreements and are not permitted to use your data for any other purposes.\n\nFor Legal Reasons: We may disclose data if required to do so by law, regulation, or legal process, or if we believe such disclosure is necessary to comply with legal obligations or to protect our rights and the rights of others.\n\nIn Business Transfers: In the event of a merger, acquisition, or sale of assets, your data may be transferred to the acquiring entity. We will notify you of such changes and how your data will be handled.\n\n',
                  ),
                  TextSpan(
                    text: '5. User Rights\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        'Access and Correction: You have the right to access and update your personal information. If you believe any data we hold about you is inaccurate or incomplete, please contact us to request corrections.\n\nData Deletion: You can request the deletion of your personal data, subject to legal and contractual obligations. We will make reasonable efforts to delete your data from our systems, except where retention is required by law.\n\nOpt-Out: You may opt-out of receiving marketing communications from us by following the unsubscribe instructions provided in our emails or contacting us directly.\n\n',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
