import 'package:flutter/material.dart';

class CustomeWidget extends StatelessWidget {
  var currentIndex;

  CustomeWidget(int index, {super.key}) {
    this.currentIndex = index;
  }

  // var currentIndex = index;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.red,
        ),
        // height: 70,
        // width: 50,

        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blueAccent,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.amber,
                child: Text('File Name ${currentIndex}'),
              ),
            ),
          ]),
        ));
  }
}
