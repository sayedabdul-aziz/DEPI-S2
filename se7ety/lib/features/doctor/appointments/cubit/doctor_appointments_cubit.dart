import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/features/patient/booking/data/appointment_model.dart';

part 'doctor_appointments_state.dart';

class DoctorAppointmentsCubit extends Cubit<DoctorAppointmentsState> {
  DoctorAppointmentsCubit(this.doctorId) : super(DoctorAppointmentsInitial());

  final String doctorId;
  StreamSubscription? _subscription;

  void watchAppointments() {
    emit(DoctorAppointmentsLoading());
    _subscription?.cancel();
    _subscription =
        FirestoreProvider.watchDoctorAppointments(doctorId).listen(
      (snapshot) {
        final appointments = snapshot.docs
            .map((doc) =>
                AppointmentModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        emit(DoctorAppointmentsSuccess(appointments));
      },
      onError: (e) => emit(DoctorAppointmentsFailure(e.toString())),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
