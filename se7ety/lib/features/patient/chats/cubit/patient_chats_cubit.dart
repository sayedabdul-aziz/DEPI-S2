import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/features/chat/data/chat_room_model.dart';

part 'patient_chats_state.dart';

class PatientChatsCubit extends Cubit<PatientChatsState> {
  PatientChatsCubit() : super(PatientChatsInitial());

  StreamSubscription? _subscription;

  void watchChatRooms() {
    final patientId = SharedPref.getUserData()?.uid ?? '';
    emit(PatientChatsLoading());
    _subscription?.cancel();
    _subscription = FirestoreProvider.watchPatientChatRooms(patientId).listen(
      (snapshot) {
        final rooms = snapshot.docs
            .map((doc) =>
                ChatRoomModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        emit(PatientChatsSuccess(rooms));
      },
      onError: (e) => emit(PatientChatsFailure(e.toString())),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
