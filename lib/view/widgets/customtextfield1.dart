import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    Key? key,
    required this.icon,
    required this.text,
    this.validator,
    this.controller,
  }) : super(key: key);
  final IconData icon;
  final String? Function(String?)? validator;
  final String text;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      cursorColor: Colors.white,
      decoration: InputDecoration(errorMaxLines: 3,
        errorStyle: const TextStyle(color: Colors.white, fontSize: 16),
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        hintText: text,
        hintStyle: TextStyle(
          fontSize: 20,
          color: Colors.white.withOpacity(0.9),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
      ),
    );
  }
}
