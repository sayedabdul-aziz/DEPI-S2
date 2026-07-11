part of 'doctor_appointments_cubit.dart';

sealed class DoctorAppointmentsState {}

final class DoctorAppointmentsInitial extends DoctorAppointmentsState {}

final class DoctorAppointmentsLoading extends DoctorAppointmentsState {}

final class DoctorAppointmentsSuccess extends DoctorAppointmentsState {
  final List<AppointmentModel> appointments;

  DoctorAppointmentsSuccess(this.appointments);
}

final class DoctorAppointmentsFailure extends DoctorAppointmentsState {
  final String message;

  DoctorAppointmentsFailure(this.message);
}
