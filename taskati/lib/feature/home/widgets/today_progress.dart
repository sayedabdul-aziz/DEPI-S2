import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/styles/colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

class TodayProgress extends StatelessWidget {
  const TodayProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<TaskModel>>(
      valueListenable: HiveHelper.taskBox.listenable(),
      builder: (context, box, child) {
        List<TaskModel> dailyTasks = [];
        for (var task in box.values) {
          if (task.date == DateFormat('dd MMM, yyyy').format(DateTime.now())) {
            dailyTasks.add(task);
          }
        }

        final completedTasks = dailyTasks
            .where((task) => task.isCompleted)
            .toList();
        final totalTasks = dailyTasks.length;
        final progressPercentage = totalTasks == 0
            ? 0
            : (completedTasks.length / totalTasks) * 100;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.primaryColor,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMd().format(DateTime.now()),
                      style: TextStyles.caption1.copyWith(
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(12),
                    Text(
                      'Your today’s task almost done!',
                      style: TextStyles.caption1.copyWith(
                        color: AppColors.backgroundColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(12),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: progressPercentage / 100,
                    color: AppColors.backgroundColor,
                    strokeWidth: 9,
                    strokeCap: StrokeCap.round,
                    backgroundColor: Color(0xff8764FF),
                    constraints: BoxConstraints(
                      minHeight: 76,
                      minWidth: 76,
                      maxHeight: 76,
                      maxWidth: 76,
                    ),
                  ),
                  Text(
                    '${progressPercentage.toStringAsFixed(0)}%',
                    style: TextStyles.caption1.copyWith(
                      color: AppColors.backgroundColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
