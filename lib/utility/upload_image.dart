import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_clone/utility/derive_info.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

XFile? _image;

class ImageUtil {
  static Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _image = pickedImage;
    }
    if (_image != null) {
      try {
        // Upload image to Firebase Storage and get the download URL
        String imagePath = await _uploadImage();

        // Update Firestore with the image path
        await _storeImageInFirestore(imagePath);

        // Fetch updated user details
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }
}

Future<String> _uploadImage() async {
  if (_image != null) {
    try {
      final String imagePath = 'user_images/${DateTime.now()}.png';
      final firebase_storage.Reference storageReference =
          firebase_storage.FirebaseStorage.instance.ref().child(imagePath);

      await storageReference.putFile(File(_image!.path));

      // Return the image path for storing in Firestore
      return imagePath;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return '';
    }
  }
  return '';
}

Future<void> _storeImageInFirestore(String imagePath) async {
  try {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    // Replace 'userID' with the actual user ID from your authentication system
    final String userID = FirebaseAuth.instance.currentUser!.uid;

    await usersCollection.doc(userID).update({
      'profilePicture': imagePath,
    });
  } catch (e) {
    print('Error storing image path in Firestore: $e');
  }
}
