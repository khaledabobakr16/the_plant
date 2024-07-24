// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

Future pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  log("No Image Selected");
}

void uploadImageToFireStorage(Uint8List? image) async {
   FirebaseAuth auth = FirebaseAuth.instance;
   FirebaseFirestore fireStore = FirebaseFirestore.instance;
   FirebaseStorage fireStorage = FirebaseStorage.instance;

   // ignore: await_only_futures
   Reference userImageRef = await fireStorage.ref().child('${auth.currentUser!.uid}.jpg');
  if (image != null) {
    await userImageRef.putData(image);
    final imageUr = await userImageRef.getDownloadURL();
    log(imageUr);
    fireStore.collection('users').doc(auth.currentUser!.uid)
         .update({
               'image':imageUr,
          });
  } else {
    log("Error, Please Try Upload image again..");
  }
}
