import 'package:flutter/material.dart';

class NonConverted extends StatelessWidget {
  const NonConverted({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
                  child: Opacity(
                    opacity: 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 100,
                          child: Image.asset('assets/images/app_logo.png'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'No Files converted yet',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                );
  }
}