import 'package:flutter/material.dart';

class custombutton extends StatelessWidget {
  const custombutton({
    super.key,
    required this.text,
    required this.onpressed,
    this.btncolor,
  });
  final String text;
  final Color? btncolor;
  final VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(400, 50),
          foregroundColor: btncolor,
          ),
      onPressed: onpressed,
      child: Text(
        text,
        style:
            const TextStyle(fontWeight: FontWeight.w900,),
      ),
    );
  }
}
