import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/doctor/appointments/cubit/doctor_appointments_cubit.dart';
import 'package:se7ety/features/doctor/appointments/page/doctor_appointments_screen.dart';
import 'package:se7ety/features/doctor/chats/cubit/doctor_chats_cubit.dart';
import 'package:se7ety/features/doctor/chats/page/doctor_chats_screen.dart';

class DoctorMainScreen extends StatefulWidget {
  const DoctorMainScreen({super.key});

  @override
  State<DoctorMainScreen> createState() => _DoctorMainScreenState();
}

class _DoctorMainScreenState extends State<DoctorMainScreen> {
  int _selectedIndex = 0;

  static const _titles = ['المواعيد', 'المحادثات'];

  @override
  Widget build(BuildContext context) {
    final doctorId = SharedPref.getUserData()?.uid ?? '';

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              DoctorAppointmentsCubit(doctorId)..watchAppointments(),
        ),
        BlocProvider(
          create: (_) => DoctorChatsCubit(doctorId)..watchChatRooms(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(_titles[_selectedIndex])),
        body: IndexedStack(
          index: _selectedIndex,
          children: const [
            DoctorAppointmentsScreen(),
            DoctorChatsScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withValues(alpha: .2)),
            ],
          ),
          child: GNav(
            curve: Curves.easeOutExpo,
            rippleColor: Colors.grey,
            hoverColor: Colors.grey,
            haptic: true,
            tabBorderRadius: 20,
            gap: 5,
            activeColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: AppColors.primaryColor,
            textStyle: TextStyles.body.copyWith(color: AppColors.whiteColor),
            tabs: const [
              GButton(
                iconSize: 28,
                icon: Icons.calendar_month_rounded,
                text: 'المواعيد',
              ),
              GButton(
                iconSize: 28,
                icon: Icons.chat_bubble_outline_rounded,
                text: 'المحادثات',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (value) => setState(() => _selectedIndex = value),
          ),
        ),
      ),
    );
  }
}
