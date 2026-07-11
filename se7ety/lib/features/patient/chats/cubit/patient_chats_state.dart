part of 'patient_chats_cubit.dart';

sealed class PatientChatsState {}

final class PatientChatsInitial extends PatientChatsState {}

final class PatientChatsLoading extends PatientChatsState {}

final class PatientChatsSuccess extends PatientChatsState {
  final List<ChatRoomModel> rooms;

  PatientChatsSuccess(this.rooms);
}

final class PatientChatsFailure extends PatientChatsState {
  final String message;

  PatientChatsFailure(this.message);
}
