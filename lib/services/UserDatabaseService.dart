import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import '../models/Doctor.dart';
import '../models/MedigoUser.dart';

class UserDatabaseService {
  
  final Firestore _db = Firestore.instance;

  Stream<MedigoUser> streamUser(String id) {
    return _db.collection('users').document(id).snapshots().map(
      (snapshot) => MedigoUser.fromFirestore(snapshot)
    );
  }

  Future<MedigoUser> getUser(String id) async {
    DocumentSnapshot snapshot = await _db.collection('users').document(id).get();
    print(snapshot.data);
    return MedigoUser.fromFirestore(snapshot);
  }

  Stream<Doctor> streamDoctor(String id) {
    return _db.collection('doctors').document(id).snapshots().map(
      (snapshot) => Doctor.fromFirestore(snapshot)
    );
  }

  Future<Doctor> getDoctor(String id) async {
    DocumentSnapshot snapshot = await _db.collection('doctors').document(id).get();
    print(snapshot.data);
    return Doctor.fromFirestore(snapshot);
  }

}