import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {

  final String userId;
  final String name;
  final String phone;
  final String email;
  final String imageUrl;
  final String field;
  final String hospital;
  final String city;
  final Position location;
  bool isVerified;
  bool isActive;

  Doctor({
    @required this.userId,
    @required this.name,
    @required this.phone,
    @required this.email,
    @required this.imageUrl,
    @required this.field,
    @required this.hospital,
    @required this.city,
    @required this.location,
    @required this.isActive,
    @required this.isVerified,
  });

  factory Doctor.fromMap(Map data) {
    return Doctor(
      userId: data['userId'] ?? null, 
      name: data['name'] ?? null,
      phone: data['phone'] ?? null,
      email: data['email'] ?? null,
      imageUrl: data['imageUrl'] ?? null, 
      field: data['field'] ?? null,
      hospital: data['hospital'] ?? null,
      city: data['city'] ?? null,
      location: Position(
        latitude: data['location'].latitude,
        longitude: data['location'].longitude,
      ) ?? null,
      isActive: data['isActive'] ?? false,
      isVerified: data['isVerified'] ?? false,
    );
  }

  factory Doctor.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data;
    if (data == null)
      return null;
    Doctor doctor = Doctor(
      userId: snapshot.documentID,
      name: data['name'] ?? null,
      phone: data['phone'] ?? null,
      email: data['email'] ?? null,
      imageUrl: data['imageUrl'] ?? null, 
      field: data['field'] ?? null,
      hospital: data['hospital'] ?? null,
      city: data['city'] ?? null,
      location: Position(
        latitude: data['location'].latitude,
        longitude: data['location'].longitude,
      ) ?? null,
      isActive: data['isActive'] ?? false,
      isVerified: data['isVerified'] ?? false,
    );
    return doctor;
  }

}