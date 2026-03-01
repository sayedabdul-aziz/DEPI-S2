import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/styles/colors.dart';
import 'package:taskati/feature/add_task/page/add_task_screen.dart';
import 'package:taskati/feature/home/widgets/tasks/task_card.dart';

class TasksBuilder extends StatefulWidget {
  const TasksBuilder({super.key, required this.tasks});
  final List<TaskModel> tasks;

  @override
  State<TasksBuilder> createState() => _TasksBuilderState();
}

class _TasksBuilderState extends State<TasksBuilder> {
  @override
  Widget build(BuildContext context) {
    if (widget.tasks.isEmpty) {
      return Center(child: Text('No tasks found'));
    }
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 50),
      itemCount: widget.tasks.length,
      separatorBuilder: (BuildContext context, int index) {
        return Gap(12);
      },
      itemBuilder: (BuildContext context, int index) {
        final task = widget.tasks[index];
        return Slidable(
          key: const ValueKey(0),

          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(
              onDismissed: () {
                HiveHelper.taskBox.delete(task.id);
              },
            ),
            children: [
              SlidableAction(
                onPressed: (context) {
                  HiveHelper.taskBox.delete(task.id);
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),

          endActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  HiveHelper.cacheTask(
                    task.id,
                    task.copyWith(isCompleted: true),
                  );
                },
                backgroundColor: Color(0xFF7BC043),
                foregroundColor: Colors.white,
                icon: Icons.done,
                label: 'Complete',
              ),
              SlidableAction(
                onPressed: (context) {
                  pushTo(context, AddEditTaskScreen(task: task));
                },
                backgroundColor: AppColors.primary50Color,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
              ),
            ],
          ),

          child: TaskCard(task: task),
        );
      },
    );
  }
}
