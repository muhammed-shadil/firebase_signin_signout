import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String? imageUrl;
final ImagePicker _imagePicker = ImagePicker();
bool isloading = false;

pickImage(BuildContext context, ImageSource source) async {
  XFile? res = await _imagePicker.pickImage(source: source);

  if (res != null) {
    return uploadtoFirebase(File(res.path), context);
  }
}

uploadtoFirebase(image, BuildContext context) async {
  try {
    Reference sr = FirebaseStorage.instance
        .ref()
        .child('Images/${DateTime.now().millisecondsSinceEpoch}.png');
    await sr
        .putFile(image)
        .whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("image uploaded"),
              ),
            ));

    return imageUrl = await sr.getDownloadURL();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("errooorrr"),
      ),
    );
  }
}
