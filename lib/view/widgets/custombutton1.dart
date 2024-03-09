import 'package:flutter/material.dart';

class custombutton extends StatelessWidget {
  const custombutton({
    super.key,
    required this.text,
    required this.onpressed,
  });
  final String text;
  final VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(400, 50)
      ),
      onPressed: onpressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
      ),
    );
  }
}
