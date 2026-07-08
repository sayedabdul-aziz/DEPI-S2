import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/patient/booking/data/appointment_model.dart';

class FirestoreProvider {
  static final db = FirebaseFirestore.instance;
  static final doctorCollection = db.collection("doctor");
  static final patientCollection = db.collection("patient");
  static final appointmentCollection = db.collection("appointment");

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

  static Future<QuerySnapshot> sortingDoctorByRating() async {
    return await doctorCollection
        .where('specialization', isNull: false)
        .orderBy('rating', descending: true)
        .get();
  }

  static Future<QuerySnapshot> getDoctorBySpecialization(
    String specialization,
  ) async {
    return await doctorCollection
        .where('specialization', isEqualTo: specialization)
        .get();
  }

  static Future<QuerySnapshot> searchForDoctorByName(String query) async {
    return await doctorCollection
        .where('specialization', isNull: false)
        .orderBy('name', descending: false)
        .startAt([query])
        .endAt(['$query\uf8ff'])
        .get();
  }

  static Future<void> createAppointment(AppointmentModel model) async {
    await appointmentCollection.doc().set(model.toJson());
  }

  static Future<void> updateAppointment(
    AppointmentModel model,
    String id,
  ) async {
    await appointmentCollection.doc(id).update(model.toJson());
  }
}
