import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final String btnText;

  SmallButton({this.btnText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 30.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.blue,
        ),
      ),
      child: Center(
        child: Text(
          btnText,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
