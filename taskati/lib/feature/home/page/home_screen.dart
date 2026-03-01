import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/functions/extensions.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/styles/colors.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/feature/add_task/page/add_task_screen.dart';
import 'package:taskati/feature/home/widgets/home_header.dart';
import 'package:taskati/feature/home/widgets/tasks/tasks_builder.dart';
import 'package:taskati/feature/home/widgets/today_progress.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatePickerController controller = DatePickerController();

  int currentIndex = 0;
  String selectedDate = DateFormat('dd MMM, yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      controller.animateToSelection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushTo(context, const AddEditTaskScreen());
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                HomeHeader(),
                Gap(24),
                TodayProgress(),
                Gap(24),
                _datePicker(),
                Gap(16),
                _filterTabs(context),
                Gap(20),
                _tasksList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DatePicker _datePicker() {
    return DatePicker(
      DateTime.now().subtract(Duration(days: 10)),
      height: 90,
      initialSelectedDate: DateTime.now(),
      controller: controller,
      selectionColor: AppColors.primaryColor,
      selectedTextColor: AppColors.backgroundColor,
      dayTextStyle: TextStyles.caption2,
      dateTextStyle: TextStyles.title.copyWith(fontWeight: FontWeight.w600),
      monthTextStyle: TextStyles.caption2,
      onDateChange: (date) {
        setState(() {
          selectedDate = DateFormat('dd MMM, yyyy').format(date);
        });
      },
    );
  }

  ButtonsTabBar _filterTabs(BuildContext context) {
    return ButtonsTabBar(
      backgroundColor: AppColors.primaryColor,
      borderWidth: 3,
      borderColor: Colors.black,
      unselectedBackgroundColor: context.hoverColor,
      labelStyle: TextStyles.caption1.copyWith(
        color: AppColors.backgroundColor,
        fontWeight: FontWeight.bold,
      ),
      radius: 15,
      unselectedLabelStyle: TextStyles.caption1.copyWith(
        color: context.isDarkMode
            ? AppColors.backgroundColor
            : AppColors.primaryColor,
      ),
      buttonMargin: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      contentCenter: true,
      width: (MediaQuery.sizeOf(context).width - 40) / 3,
      tabs: [
        Tab(text: 'All'),
        Tab(text: 'In Progress'),
        Tab(text: 'Completed'),
      ],
    );
  }

  Expanded _tasksList() {
    return Expanded(
      child: ValueListenableBuilder<Box<TaskModel>>(
        valueListenable: HiveHelper.taskBox.listenable(),
        builder: (context, box, child) {
          final List<TaskModel> dailyTasks = [];

          for (var task in box.values) {
            if (task.date == selectedDate) {
              dailyTasks.add(task);
            }
          }
          final inProgressTasks = dailyTasks
              .where((task) => !task.isCompleted)
              .toList();
          final completedTasks = dailyTasks
              .where((task) => task.isCompleted)
              .toList();

          return TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              TasksBuilder(tasks: dailyTasks),
              TasksBuilder(tasks: inProgressTasks),
              TasksBuilder(tasks: completedTasks),
            ],
          );
        },
      ),
    );
  }
}
