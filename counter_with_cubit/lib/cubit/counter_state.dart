// functions =>  increment , decrement
// states => counterIncrement , counterDecrement

class CounterState {}

class CounterInitialState extends CounterState {}

class CounterLoadingState extends CounterState {}

class CounterUpdatedState extends CounterState {
  bool isIncrement;
  int counter = 0;

  CounterUpdatedState({required this.isIncrement, required this.counter});
}




// shape
// Circle , Rectangle

// Shape c = Rectangle();

// getArea(Shape c){
    // c.getArea();
// }