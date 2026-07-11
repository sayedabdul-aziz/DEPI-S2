import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/features/chat/data/chat_room_model.dart';

part 'doctor_chats_state.dart';

class DoctorChatsCubit extends Cubit<DoctorChatsState> {
  DoctorChatsCubit(this.doctorId) : super(DoctorChatsInitial());

  final String doctorId;
  StreamSubscription? _subscription;

  void watchChatRooms() {
    emit(DoctorChatsLoading());
    _subscription?.cancel();
    _subscription = FirestoreProvider.watchDoctorChatRooms(doctorId).listen(
      (snapshot) {
        final rooms = snapshot.docs
            .map((doc) =>
                ChatRoomModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        emit(DoctorChatsSuccess(rooms));
      },
      onError: (e) => emit(DoctorChatsFailure(e.toString())),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
