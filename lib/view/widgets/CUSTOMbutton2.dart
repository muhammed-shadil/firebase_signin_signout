import 'package:flutter/material.dart';

class custombutton2 extends StatelessWidget {
  const custombutton2({
    super.key,
    required this.text,
    required this.onpressed, this.btncolor,
  });
  final String text;
  final Color? btncolor;
  final VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor:btncolor),
      onPressed: onpressed,
      child: Text(
        text,
        style: const TextStyle( fontWeight: FontWeight.bold,color: Colors.black),
      ),
    );
  }
}
