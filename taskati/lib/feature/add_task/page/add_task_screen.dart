import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/extensions.dart';
import 'package:taskati/core/functions/navigations.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/core/styles/colors.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/core/widgets/custom_svg_picture.dart';
import 'package:taskati/core/widgets/custom_text_form_field.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/feature/add_task/widgets/task_date_time_card.dart';

class AddEditTaskScreen extends StatefulWidget {
  const AddEditTaskScreen({super.key, this.task});

  final TaskModel? task;

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  late String _date;
  late String _startTime;
  late String _endTime;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descriptionController = TextEditingController(
      text: widget.task?.description ?? '',
    );
    _date =
        widget.task?.date ?? DateFormat('dd MMM, yyyy').format(DateTime.now());
    _startTime =
        widget.task?.startTime ?? DateFormat('hh:mm a').format(DateTime.now());
    _endTime =
        widget.task?.endTime ?? DateFormat('hh:mm a').format(DateTime.now());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 56,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomSvgPicture(
            path: AppImages.backSvg,
            width: 24,
            height: 24,
            color: context.theme.iconTheme.color,
          ),
        ),
        title: Text(widget.task != null ? 'Edit Task' : 'Add Task'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: TextStyles.caption1.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
            const Gap(8),
            CustomTextFormField(
              controller: _titleController,
              
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            const Gap(18),
            Text(
              'Description',
              style: TextStyles.caption1.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
            const Gap(8),
            CustomTextFormField(
              controller: _descriptionController,
              maxLines: 4,
              minLines: 4,
              contentPadding: const EdgeInsets.all(16),
            ),
            const Gap(30),
            TaskDateTimeCard(
              title: 'Date',
              value: _date,
              iconPath: AppImages.calendar,
              onTap: () async {
                var selectedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  initialDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );
                if (selectedDate != null) {
                  setState(() {
                    _date = DateFormat('dd MMM, yyyy').format(selectedDate);
                  });
                }
              },
            ),
            const Gap(24),
            TaskDateTimeCard(
              title: 'Start Time',
              value: _startTime,
              iconPath: AppImages.timeSvg,
              onTap: () => _selectTime(true),
            ),
            const Gap(24),
            TaskDateTimeCard(
              title: 'End Time',
              value: _endTime,
              iconPath: AppImages.timeSvg,
              onTap: () => _selectTime(false),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(22, 8, 22, 30),
        child: MainButton(
          text: widget.task != null ? 'Save' : 'Add Task',
          onPressed: () {
            if (widget.task != null) {
              HiveHelper.cacheTask(
                widget.task!.id,
                TaskModel(
                  id: widget.task!.id,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  date: _date,
                  startTime: _startTime,
                  endTime: _endTime,
                  isCompleted: false,
                ),
              );
            } else {
              String id = DateTime.now().millisecondsSinceEpoch.toString();
              HiveHelper.cacheTask(
                id,
                TaskModel(
                  id: id,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  date: _date,
                  startTime: _startTime,
                  endTime: _endTime,
                  isCompleted: false,
                ),
              );
            }
            pop(context);
          },
        ),
      ),
    );
  }

  Future<void> _selectTime(bool isStart) async {
    var selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      var dateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        selectedTime.hour,
        selectedTime.minute,
      );
      setState(() {
        if (isStart) {
          _startTime = DateFormat('hh:mm a').format(dateTime);
        } else {
          _endTime = DateFormat('hh:mm a').format(dateTime);
        }
      });
    }
  }
}
