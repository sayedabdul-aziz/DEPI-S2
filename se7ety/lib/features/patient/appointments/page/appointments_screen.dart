import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/patient/appointments/cubit/appointments_cubit.dart';
import 'package:se7ety/features/patient/appointments/widgets/appointment_card.dart';

class MyAppointmentsScreen extends StatelessWidget {
  const MyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppointmentsCubit()..getAppointments(),
      child: const _MyAppointmentsView(),
    );
  }
}

class _MyAppointmentsView extends StatelessWidget {
  const _MyAppointmentsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مواعيد الحجز')),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<AppointmentsCubit, AppointmentsState>(
          builder: (context, state) {
            if (state is AppointmentsLoading || state is AppointmentsInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AppointmentsFailure) {
              return Center(child: Text(state.message));
            }

            if (state is AppointmentsSuccess) {
              if (state.appointments.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/no_scheduled.svg',
                        width: 250,
                      ),
                      Text('لا يوجد حجوزات قادمة', style: TextStyles.body),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 16),
                scrollDirection: Axis.vertical,
                itemCount: state.appointments.length,
                separatorBuilder: (_, _) => const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  return AppointmentCard(
                    model: state.appointments[index],
                    onRemove: () =>
                        _showDeleteDialog(context, state.documentIds[index]),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog.adaptive(
          title: const Text("حذف الحجز"),
          content: const Text("هل متاكد من حذف هذا الحجز ؟"),
          actions: [
            TextButton(
              child: const Text("لا"),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: const Text("نعم"),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<AppointmentsCubit>().deleteAppointment(docId);
              },
            ),
          ],
        );
      },
    );
  }
}
