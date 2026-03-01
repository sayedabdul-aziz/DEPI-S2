import 'package:hive_ce/hive_ce.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/models/user_model.dart';

@GenerateAdapters([AdapterSpec<TaskModel>(), AdapterSpec<UserModel>()])
part 'hive_adapters.g.dart';
