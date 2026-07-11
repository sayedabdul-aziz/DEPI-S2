part of 'appointments_cubit.dart';

sealed class AppointmentsState {}

final class AppointmentsInitial extends AppointmentsState {}

final class AppointmentsLoading extends AppointmentsState {}

final class AppointmentsSuccess extends AppointmentsState {
  final List<AppointmentModel> appointments;
  final List<String> documentIds;

  AppointmentsSuccess({
    required this.appointments,
    required this.documentIds,
  });
}

final class AppointmentsFailure extends AppointmentsState {
  final String message;

  AppointmentsFailure(this.message);
}

final class AppointmentDeleteSuccess extends AppointmentsState {}
