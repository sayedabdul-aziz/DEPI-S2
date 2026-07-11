part of 'doctor_chats_cubit.dart';

sealed class DoctorChatsState {}

final class DoctorChatsInitial extends DoctorChatsState {}

final class DoctorChatsLoading extends DoctorChatsState {}

final class DoctorChatsSuccess extends DoctorChatsState {
  final List<ChatRoomModel> rooms;

  DoctorChatsSuccess(this.rooms);
}

final class DoctorChatsFailure extends DoctorChatsState {
  final String message;

  DoctorChatsFailure(this.message);
}
