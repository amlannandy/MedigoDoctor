import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MedigoUser {

  final String userId;
  final String name;
  final int age;
  final String imageUrl;
  final String city;
  final Position location;

  MedigoUser({
    @required this.userId,
    @required this.name,
    @required this.age,
    @required this.city,
    @required this.location,
    @required this.imageUrl,
  });

  factory MedigoUser.fromMap(Map data) {
    return MedigoUser(
      userId: data['userId'] ?? null,
      name: data['name'] ?? null,
      age: data['age'] ?? null,
      city: data['city'] ?? null,
      imageUrl: data['imageUrl'] ?? "https://firebasestorage.googleapis.com/v0/b/agroacres-bbsr.appspot.com/o/MedigoUser_profile_photos%2Fdefault.png?alt=media&token=bce57e61-72f5-4a9e-a211-c40523912169",
      location: Position(
        latitude: data['location'].latitude,
        longitude: data['location'].longitude,
      ) ?? null,
    );
  }

  factory MedigoUser.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data;
    if (data == null)
      return null;
    MedigoUser user = MedigoUser(
      userId: snapshot.documentID,
      name: data['name'] ?? null,
      age: data['age'] ?? null,
      city: data['city'] ?? null,
      imageUrl: data['imageUrl'] ?? "https://firebasestorage.googleapis.com/v0/b/agroacres-bbsr.appspot.com/o/MedigoUser_profile_photos%2Fdefault.png?alt=media&token=bce57e61-72f5-4a9e-a211-c40523912169",
      location: Position(
        latitude: data['location'].latitude,
        longitude: data['location'].longitude,
      ) ?? null,
    );
    return user;
  }

}