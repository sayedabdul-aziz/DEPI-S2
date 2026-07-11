import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/features/chat/data/chat_message_model.dart';
import 'package:se7ety/features/chat/data/chat_room_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    this.doctorImage,
  }) : super(ChatInitial());

  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  final String? doctorImage;

  StreamSubscription? _subscription;

  String get currentUserId => SharedPref.getUserData()?.uid ?? '';

  void watchMessages() {
    emit(ChatLoading());
    _subscription?.cancel();
    _subscription =
        FirestoreProvider.watchChatMessages(
          patientId: patientId,
          doctorId: doctorId,
        ).listen((snapshot) {
          final messages = snapshot.docs
              .map(
                (doc) => ChatMessageModel.fromJson(
                  doc.data() as Map<String, dynamic>,
                ),
              )
              .toList();
          emit(ChatSuccess(messages));
        }, onError: (e) => emit(ChatFailure(e.toString())));
  }

  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    try {
      final now = Timestamp.now();
      await FirestoreProvider.sendChatMessage(
        room: ChatRoomModel(
          roomId: FirestoreProvider.chatRoomId(patientId, doctorId),
          patientId: patientId,
          patientName: patientName,
          doctorId: doctorId,
          doctorName: doctorName,
          doctorImage: doctorImage,
          lastMessage: trimmed,
          lastTimestamp: now,
        ),
        message: ChatMessageModel(
          text: trimmed,
          senderId: currentUserId,
          timestamp: now,
        ),
      );
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
