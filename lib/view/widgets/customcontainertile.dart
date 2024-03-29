import 'package:flutter/material.dart';

class Profiletile extends StatelessWidget {
  const Profiletile({super.key, this.label, this.content});
  final String? label;
  final String? content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white60),
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$label",
              style: const TextStyle( color: Colors.black87,fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "$content",
              style: const TextStyle( color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
