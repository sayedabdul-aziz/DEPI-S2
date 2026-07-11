import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/patient/chats/cubit/patient_chats_cubit.dart';

class PatientChatsScreen extends StatelessWidget {
  const PatientChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PatientChatsCubit()..watchChatRooms(),
      child: const _PatientChatsView(),
    );
  }
}

class _PatientChatsView extends StatelessWidget {
  const _PatientChatsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientChatsCubit, PatientChatsState>(
      builder: (context, state) {
        if (state is PatientChatsLoading || state is PatientChatsInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is PatientChatsFailure) {
          return Center(child: Text(state.message));
        }

        if (state is PatientChatsSuccess) {
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
                leading: CircleAvatar(
                  backgroundColor: AppColors.accentColor,
                  backgroundImage: room.doctorImage != null
                      ? NetworkImage(room.doctorImage!)
                      : null,
                  child: room.doctorImage == null
                      ? const Icon(Icons.person, color: AppColors.primaryColor)
                      : null,
                ),
                title: Text(room.doctorName, style: TextStyles.title),
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
