import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Doctor.dart';
import '../models/Clinic.dart';
import '../models/MedigoUser.dart';
import '../models/Prescription.dart';
import '../models/MedicalReport.dart';

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

  Stream<Clinic> streamClinic(String id) {
    return _db.collection('clinics').document(id).snapshots().map(
      (snapshot) => Clinic.fromFirestore(snapshot)
    );
  }

  Future<Clinic> getClinic(String id) async {
    DocumentSnapshot snapshot = await _db.collection('clinics').document(id).get();
    print(snapshot.data);
    return Clinic.fromFirestore(snapshot);
  }

  Stream<Prescription> streamPrescription(String id) {
    return _db.collection('prescriptions').document(id).snapshots().map(
      (snapshot) => Prescription.fromFirestore(snapshot)
    );
  }

  Future<Prescription> getPrescription(String id) async {
    DocumentSnapshot snapshot = await _db.collection('prescriptions').document(id).get();
    print(snapshot.data);
    return Prescription.fromFirestore(snapshot);
  }

  Stream<MedicalReport> streamMedicalReport(String id) {
    return _db.collection('medicalreports').document(id).snapshots().map(
      (snapshot) => MedicalReport.fromFirestore(snapshot)
    );
  }

  Future<MedicalReport> getMedicalReport(String id) async {
    DocumentSnapshot snapshot = await _db.collection('medicalreports').document(id).get();
    print(snapshot.data);
    return MedicalReport.fromFirestore(snapshot);
  }

}