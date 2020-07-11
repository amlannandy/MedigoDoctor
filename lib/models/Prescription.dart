import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Prescription {

  final String id;
  final String userId;
  final String doctorId;
  final String data;
  final String date;

  Prescription({
    @required this.id,
    @required this.userId,
    @required this.doctorId,
    @required this.data,
    @required this.date,
  });

  factory Prescription.fromFirestore(DocumentSnapshot snapshot) {
    final doc = snapshot.data;
    Prescription prescription = Prescription(
      id: snapshot.documentID,
      userId: doc['userId'] ?? null,
      doctorId: doc['doctorId'] ?? null,
      data: doc['data'] ?? '',
      date: doc['date'] ?? null,
    );
    return prescription;
  }

}