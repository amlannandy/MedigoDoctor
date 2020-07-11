import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import '../screens/RegistrationScreens/local_widgets/FieldDropdownList.dart';

class UserInfoProvider {

  static File currentImage;
  static String currentImageUrl = "";
  static String clinicImageUrl = "";

  static void uploadUserInfo({BuildContext context, String name, String age, String field, String hospital, String location, Position userPosition, String experience}) async {
    if (name.isEmpty || age.isEmpty || field.isEmpty || hospital.isEmpty || location.isEmpty || experience.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill up all the fields");
      return;
    }
    if (age.length != 2) {
      Fluttertoast.showToast(msg: "Please enter a valid age");
      return;
    }
    try {
      int newAge = int.parse(age);
      if (newAge < 18) {
        Fluttertoast.showToast(msg: "Please enter a valid age");
        return;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Please enter a valid age");
    }
    if (userPosition == null) {
      userPosition = Position(latitude: 23, longitude: 87);
    }
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('doctors').document(user.uid).setData({
      'name' : name,
      'age' : int.parse(age),
      'field' : field,
      'hospital' : hospital,
      'city' : location,
      'imageUrl' : currentImageUrl.isEmpty ? "https://firebasestorage.googleapis.com/v0/b/medigo-bbsr.appspot.com/o/stock_assets%2Fdefault_doctor.png?alt=media&token=546af140-247e-4775-8e46-b79084ab817a" : currentImageUrl,
      'location' : GeoPoint(userPosition.latitude, userPosition.longitude),
      'experience' : int.parse(experience),
    });
    Navigator.of(context).pushReplacementNamed('/init');
  }

  static void uploadClinicData({BuildContext context, String name, String phone, String address, Position location}) async {
    if (name.isEmpty || phone.isEmpty || address.isEmpty || location == null) {
      Fluttertoast.showToast(msg: "Please fill up all the fields");
      return;
    }
    if (clinicImageUrl.isEmpty) {
      Fluttertoast.showToast(msg: "Please add an image");
      return;
    }
    try {
      int.parse(phone);
      if (phone.length != 10) {
        Fluttertoast.showToast(msg: "Please enter a valid phone number");
        return;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Please enter a valid age");
    }
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String clinicId = Firestore.instance.collection('clinics').document().documentID;
    Firestore.instance.collection('clinics').document(clinicId).setData({
      'name' : name,
      'phone' : phone,
      'address' : address,
      'imageUrl' : clinicImageUrl,
      'location' : GeoPoint(location.latitude, location.longitude),
      'doctorId' : user.uid,
    });
    Firestore.instance.collection('doctors').document(user.uid).updateData({
      'clinicId' : clinicId,
    });
    Fluttertoast.showToast(msg: "Data uploaded", backgroundColor: Colors.green, textColor: Colors.white);
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed('/init');
  }

  static Future takePicture(BuildContext context, Function notifyChanges, {bool isClinic = false}) async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null)
      return;
    currentImage = imageFile;
    StorageReference firebaseStorageRef;
    if (isClinic) {
      firebaseStorageRef = FirebaseStorage.instance.ref().child('clinicPictures/${Path.basename(currentImage.path)}}');
    } else {
      firebaseStorageRef = FirebaseStorage.instance.ref().child('doctorProfilePictures/${Path.basename(currentImage.path)}}');
    }
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(currentImage);
    await uploadTask.onComplete;
    firebaseStorageRef.getDownloadURL().then((fileUrl) {
      if (isClinic) {
        clinicImageUrl = fileUrl;
      } else {
        currentImageUrl = fileUrl;
      }
      notifyChanges();
    });
  }

  static Future uploadPicture(BuildContext context, Function notifyChanges, {bool isClinic = false}) async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imageFile == null)
      return;
    currentImage = imageFile;
    StorageReference firebaseStorageRef;
    if (isClinic) {
      firebaseStorageRef = FirebaseStorage.instance.ref().child('clinicPictures/${Path.basename(currentImage.path)}}');
    } else {
      firebaseStorageRef = FirebaseStorage.instance.ref().child('doctorProfilePictures/${Path.basename(currentImage.path)}}');
    }
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(currentImage);
    await uploadTask.onComplete;
    firebaseStorageRef.getDownloadURL().then((fileUrl) {
      if (isClinic) {
        clinicImageUrl = fileUrl;
      } else {
        currentImageUrl = fileUrl;
      }
      notifyChanges();
    });
  }


  static void updateUserInfo({String name, String age, String location}) async {
    if (name.isEmpty || age.isEmpty || location.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill up all the fields");
      return;
    }
    if (age.length != 2) {
      Fluttertoast.showToast(msg: "Please enter a valid age");
      return;
    }
    try {
      int newAge = int.parse(age);
      if (newAge < 18) {
        Fluttertoast.showToast(msg: "Please enter a valid age");
        return;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Please enter a valid age");
    }
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('users').document(user.uid).updateData({
      'name' : name,
      'age' : int.parse(age),
      'city' : location,
    });
    Fluttertoast.showToast(msg: "Profile updated", backgroundColor: Colors.green, textColor: Colors.white);
  }

  static void showFieldDropdown(BuildContext context, Function callback) {
    showDialog(
      context: context,
      child: FieldDropdownList(callback),
    );
  }

}