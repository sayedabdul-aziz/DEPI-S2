import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  final String roomId;
  final String patientId;
  final String patientName;
  final String? patientImage;
  final String doctorId;
  final String doctorName;
  final String? doctorImage;
  final String lastMessage;
  final Timestamp lastTimestamp;

  ChatRoomModel({
    required this.roomId,
    required this.patientId,
    required this.patientName,
    this.patientImage,
    required this.doctorId,
    required this.doctorName,
    this.doctorImage,
    required this.lastMessage,
    required this.lastTimestamp,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      roomId: json['roomId'] as String? ?? '',
      patientId: json['patientId'] as String? ?? '',
      patientName: json['patientName'] as String? ?? '',
      patientImage: json['patientImage'] as String?,
      doctorId: json['doctorId'] as String? ?? '',
      doctorName: json['doctorName'] as String? ?? '',
      doctorImage: json['doctorImage'] as String?,
      lastMessage: json['lastMessage'] as String? ?? '',
      lastTimestamp: json['lastTimestamp'] as Timestamp? ??
          Timestamp.fromMillisecondsSinceEpoch(0),
    );
  }

  ChatRoomModel copyWith({
    String? roomId,
    String? patientId,
    String? patientName,
    String? patientImage,
    String? doctorId,
    String? doctorName,
    String? doctorImage,
    String? lastMessage,
    Timestamp? lastTimestamp,
  }) {
    return ChatRoomModel(
      roomId: roomId ?? this.roomId,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      patientImage: patientImage ?? this.patientImage,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      doctorImage: doctorImage ?? this.doctorImage,
      lastMessage: lastMessage ?? this.lastMessage,
      lastTimestamp: lastTimestamp ?? this.lastTimestamp,
    );
  }

  Map<String, dynamic> toJson() => {
        'roomId': roomId,
        'patientId': patientId,
        'patientName': patientName,
        'patientImage': patientImage,
        'doctorId': doctorId,
        'doctorName': doctorName,
        'doctorImage': doctorImage,
        'lastMessage': lastMessage,
        'lastTimestamp': lastTimestamp,
      };
}
