import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/services/firebase/firestore_provider.dart';
import 'package:se7ety/features/patient/booking/data/appointment_model.dart';

part 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  AppointmentsCubit() : super(AppointmentsInitial());

  StreamSubscription? _subscription;

  void getAppointments() {
    emit(AppointmentsLoading());
    _subscription?.cancel();
    _subscription = FirestoreProvider.watchPatientAppointments().listen((
      snapshot,
    ) {
      final appointments = snapshot.docs
          .map(
            (doc) =>
                AppointmentModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
      final documentIds = snapshot.docs.map((doc) => doc.id).toList();
      emit(
        AppointmentsSuccess(
          appointments: appointments,
          documentIds: documentIds,
        ),
      );
    }, onError: (e) => emit(AppointmentsFailure(e.toString())));
  }

  Future<void> deleteAppointment(String docId) async {
    try {
      await FirestoreProvider.deleteAppointment(docId);
    } catch (e) {
      emit(AppointmentsFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
