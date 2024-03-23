import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String? imageUrl;
final ImagePicker _imagePicker = ImagePicker();
bool isloading = false;

pickImage(BuildContext context, ImageSource source, String? email) async {
  XFile? res = await _imagePicker.pickImage(source: source);

  if (res != null) {
    try {
      String filename = 'Images/${DateTime.now().millisecondsSinceEpoch}.png';
      Reference sr = FirebaseStorage.instance.ref().child(filename);
      await sr
          .putFile(File(res.path))
          .whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("image uploaded"),
                ),
              ));

      imageUrl = await sr.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get()
          .then((QuerySnapshot) {
        QuerySnapshot.docs.forEach((doc) {
          doc.reference.update({'image': imageUrl});
        });
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erroorr,failed to upload image"),
        ),
      );
    }
  }
}
