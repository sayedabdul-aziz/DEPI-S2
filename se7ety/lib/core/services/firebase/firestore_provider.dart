import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';

class FirestoreProvider {
  static final db = FirebaseFirestore.instance;
  static final doctorCollection = db.collection("doctor");
  static final patientCollection = db.collection("patient");

  static Future<void> createDoctor(DoctorModel model) async {
    await doctorCollection.doc(model.uid).set(model.toJson());
  }

  static Future<void> updateDoctor(DoctorModel model) async {
    await doctorCollection.doc(model.uid).update(model.toUpdateData());
  }

  static Future<void> deleteDoctor(String uid) async {
    await doctorCollection.doc(uid).delete();
  }

  static Future<void> createPatient(PatientModel model) async {
    await patientCollection.doc(model.uid).set(model.toJson());
  }

  static Future<void> updatePatient(PatientModel model) async {
    await patientCollection.doc(model.uid).update(model.toUpdateData());
  }
}
