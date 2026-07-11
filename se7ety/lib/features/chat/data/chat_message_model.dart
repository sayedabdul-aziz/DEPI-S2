import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel {
  final String text;
  final String senderId;
  final Timestamp timestamp;

  ChatMessageModel({
    required this.text,
    required this.senderId,
    required this.timestamp,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      text: json['text'] as String,
      senderId: json['senderId'] as String,
      timestamp: json['timestamp'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() => {
        'text': text,
        'senderId': senderId,
        'timestamp': timestamp,
      };
}
