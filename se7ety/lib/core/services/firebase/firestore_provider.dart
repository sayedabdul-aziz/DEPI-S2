import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/chat/data/chat_message_model.dart';
import 'package:se7ety/features/chat/data/chat_room_model.dart';
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

  static Future<DocumentSnapshot> getPatientById() async {
    String uid = SharedPref.getUserData()?.uid ?? '';
    return await patientCollection.doc(uid).get();
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

  static Future<void> deleteAppointment(String id) async {
    await appointmentCollection.doc(id).delete();
  }

  static Future<QuerySnapshot> getPatientAppointments() async {
    var id = SharedPref.getUserData()?.uid;
    return await appointmentCollection
        .where('patientID', isEqualTo: id)
        .orderBy('date', descending: false)
        .get();
  }

  static Stream<QuerySnapshot> watchPatientAppointments() {
    var id = SharedPref.getUserData()?.uid;
    return appointmentCollection
        .where('patientID', isEqualTo: id)
        .orderBy('date', descending: false)
        .snapshots();
  }

  static Stream<QuerySnapshot> watchDoctorAppointments(String doctorId) {
    return appointmentCollection
        .where('doctorID', isEqualTo: doctorId)
        .orderBy('date', descending: false)
        .snapshots();
  }

  static final chatRoomsCollection = db.collection('chat_rooms');

  static String chatRoomId(String patientId, String doctorId) =>
      '${patientId}_$doctorId';

  static DocumentReference _roomRef(String patientId, String doctorId) =>
      chatRoomsCollection.doc(chatRoomId(patientId, doctorId));

  static Stream<QuerySnapshot> watchChatMessages({
    required String patientId,
    required String doctorId,
  }) {
    return _roomRef(patientId, doctorId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  static Stream<QuerySnapshot> watchDoctorChatRooms(String doctorId) {
    return chatRoomsCollection
        .where('doctorId', isEqualTo: doctorId)
        // .orderBy('lastTimestamp', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot> watchPatientChatRooms(String patientId) {
    return chatRoomsCollection
        .where('patientId', isEqualTo: patientId)
        // .orderBy('lastTimestamp', descending: true)
        .snapshots();
  }

  static Future<void> sendChatMessage({
    required ChatRoomModel room,
    required ChatMessageModel message,
  }) async {
    final roomRef = _roomRef(room.patientId, room.doctorId);
    final batch = db.batch();
    final msgRef = roomRef.collection('messages').doc();
    batch.set(msgRef, message.toJson());
    batch.set(
      roomRef,
      room
          .copyWith(
            roomId: chatRoomId(room.patientId, room.doctorId),
            lastMessage: message.text,
            lastTimestamp: message.timestamp,
          )
          .toJson(),
    );
    await batch.commit();
  }
}
