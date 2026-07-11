import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/doctor/appointments/cubit/doctor_appointments_cubit.dart';
import 'package:se7ety/features/patient/booking/data/appointment_model.dart';

class DoctorAppointmentsScreen extends StatelessWidget {
  const DoctorAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorAppointmentsCubit, DoctorAppointmentsState>(
      builder: (context, state) {
        if (state is DoctorAppointmentsLoading ||
            state is DoctorAppointmentsInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DoctorAppointmentsFailure) {
          log(state.message);
          return Center(child: Text(state.message));
        }

        if (state is DoctorAppointmentsSuccess) {
          if (state.appointments.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/no_scheduled.svg',
                    width: 250,
                  ),
                  Text('لا يوجد مواعيد قادمة', style: TextStyles.body),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.appointments.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) =>
                _AppointmentTile(model: state.appointments[index]),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _AppointmentTile extends StatelessWidget {
  const _AppointmentTile({required this.model});

  final AppointmentModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(model.name, style: TextStyles.title),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.calendar_month_rounded,
                color: AppColors.primaryColor,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                DateFormat.yMMMMd('ar').format(model.date),
                style: TextStyles.small,
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.watch_later_outlined,
                color: AppColors.primaryColor,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                DateFormat.jm('ar').format(model.date),
                style: TextStyles.small,
              ),
            ],
          ),
          if (model.description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              model.description,
              style: TextStyles.small.copyWith(color: AppColors.greyColor),
            ),
          ],
        ],
      ),
    );
  }
}
