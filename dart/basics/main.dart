void main() {
  List<int> numbers = [1, 2, 3, 4, 5];
  for (var number in numbers) {
    print(number);
  }

  numbers.forEach((value) {
    print(value);
  });

  display("John", 20);
  display1("John", 21);
  display2(age: 21, name: "John");
  display3(name: "John");
  display4("Ahmed", gender: "male");
}

// 1) Positional Parameters  (ordered, required)
void display(String name, int age) {
  print("name : $name, age : $age");
}

// 2) Positional Parameters  (ordered, required & optional)
void display1(String name, [int age = 20]) {
  print("name : $name, age : $age");
}

// 3) Named Parameters  (Not ordered, required)
void display2({required String name, required int age}) {
  print("name : $name, age : $age");
}

// 4) Named Parameters  (Not ordered, required & optional)
void display3({required String name, int age = 20}) {
  print("name : $name, age : $age");
}

// 5) Mix  (Not ordered, required & optional)
void display4(String name, {required String gender, int age = 20}) {
  print("name : $name, age : $age");
}

int fact(int n){
  if(n==1){
    return 1;
  }else{
   return n*fact(n-1); // 5*4*3*2*1
  }
}
