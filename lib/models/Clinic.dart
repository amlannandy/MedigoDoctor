import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Clinic {

  final String id;
  final String name;
  final String address;
  final Position location;
  final String imageUrl;
  final String phone;
  final String doctorId;

  Clinic({
    @required this.id,
    @required this.name,
    @required this.address,
    @required this.location,
    @required this.imageUrl,
    @required this.phone,
    @required this.doctorId,
  });

  factory Clinic.fromFirestore(DocumentSnapshot snapshot) {
    final doc = snapshot.data;
    Clinic clinic = Clinic(
      id: snapshot.documentID,
      name: doc['name'] ?? null,
      address: doc['address'] ?? null,
      location: Position( latitude: doc['location'].latitude, longitude: doc['location'].longitude) ?? null,
      imageUrl: doc['imageUrl'] ?? null,
      phone: doc['phone'] ?? null,
      doctorId: doc['doctorId'] ?? null,
    );
    return clinic;
  }

}