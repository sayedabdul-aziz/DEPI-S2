class CounterState {
  int counter = 0;

  CounterState({this.counter = 0});
}

class CounterInitialState extends CounterState {
  CounterInitialState({super.counter = 0});
}

class CounterLoadingState extends CounterState {}

class CounterUpdatedState extends CounterState {
  bool isIncrement;

  CounterUpdatedState({required this.isIncrement, required super.counter});
}
