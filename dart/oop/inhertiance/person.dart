class Person {
  String? name;
  String? id;
  Person({this.name, required this.id});

  void display() {
    print("name : $name, id : $id");
  }
}

class Student extends Person {
  String? grade;

  // Student({this.grade, super.name, super.id});
  Student({this.grade, required String id, required String name})
    : super(id: id, name: name);

  @override
  void display() {
    print("name : $name, id : $id, grade : $grade");
  }
}

class Doctor extends Person {
  double? salary;

  Doctor({required this.salary, required super.name, required super.id});

  @override
  display() {
    print("name : $name, id : $id, salary : $salary");
  }
}
