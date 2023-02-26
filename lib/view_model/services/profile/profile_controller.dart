import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_media/res/color.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view_model/services/session_controller.dart';

class ProfileController with ChangeNotifier {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      notifyListeners();
      uploadImage(context);
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      notifyListeners();
      uploadImage(context);
    }
  }

  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Container(
            height: 120,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickCameraImage(context);
                    Navigator.pop(context);
                  },
                  title: const Text('Camera'),
                  leading: const Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.primaryIconColor,
                  ),
                ),
                ListTile(
                  onTap: () {
                    pickGalleryImage(context);
                    Navigator.pop(context);
                  },
                  title: const Text('Gallery'),
                  leading: const Icon(
                    Icons.broken_image_outlined,
                    color: AppColors.primaryIconColor,
                  ),
                ),
              ],
            ),
          ));
        });
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileImage' + SessionController().userId.toString());
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);
    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    ref
        .child(SessionController().userId.toString())
        .update({"profile": newUrl.toString()}).then((value) {
      setLoading(false);
      Utils.ToastMessage("your profile is updated");
      _image = null;
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.ToastMessage(error.toString());
    });
  }
}
