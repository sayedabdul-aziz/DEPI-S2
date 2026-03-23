// import 'package:counter_with_cubit/cubit/counter_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CounterCubit extends Cubit<CounterState> {
//   CounterCubit() : super(CounterInitialState());

//   int counter = 0;

//   Future<void> increment() async {
//     emit(CounterLoadingState());
//     await Future.delayed(const Duration(seconds: 1));
//     counter++;
//     emit(CounterUpdatedState(isIncrement: true, counter: counter));
//   }

//   Future<void> decrement() async {
//     emit(CounterLoadingState());
//     await Future.delayed(const Duration(seconds: 1));
//     counter--;
//     emit(CounterUpdatedState(isIncrement: false, counter: counter));
//   }
// }
