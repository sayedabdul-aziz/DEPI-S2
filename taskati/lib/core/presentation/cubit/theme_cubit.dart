import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskati/core/presentation/cubit/theme_state.dart';
import 'package:taskati/core/services/hive_helper.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitialState());

  bool isDarkMode = HiveHelper.getData(HiveHelper.isDarkModeKey) == true;

  void changeTheme() {
    isDarkMode = !isDarkMode;
    HiveHelper.cacheData(HiveHelper.isDarkModeKey, isDarkMode);
    emit(ThemeChangedState());
  }
}
