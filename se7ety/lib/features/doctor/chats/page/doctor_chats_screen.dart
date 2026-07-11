import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/doctor/chats/cubit/doctor_chats_cubit.dart';

class DoctorChatsScreen extends StatelessWidget {
  const DoctorChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorChatsCubit, DoctorChatsState>(
      builder: (context, state) {
        if (state is DoctorChatsLoading || state is DoctorChatsInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DoctorChatsFailure) {
          log(state.message);
          return Center(child: Text(state.message));
        }

        if (state is DoctorChatsSuccess) {
          if (state.rooms.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 80,
                    color: AppColors.greyColor,
                  ),
                  const SizedBox(height: 16),
                  Text('لا توجد محادثات', style: TextStyles.body),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.rooms.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final room = state.rooms[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 8,
                ),
                leading: const CircleAvatar(
                  backgroundColor: AppColors.accentColor,
                  child: Icon(Icons.person, color: AppColors.primaryColor),
                ),
                title: Text(room.patientName, style: TextStyles.title),
                subtitle: Text(
                  room.lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.small.copyWith(color: AppColors.greyColor),
                ),
                onTap: () => pushTo(
                  context,
                  Routes.chat,
                  extra: {
                    'patientId': room.patientId,
                    'patientName': room.patientName,
                    'doctorId': room.doctorId,
                    'doctorName': room.doctorName,
                  },
                ),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
