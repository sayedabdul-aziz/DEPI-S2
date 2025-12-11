import 'person.dart';

void main() {
  Person p1 = Person(name: "Ahmed", age: 20, gender: "male");
  p1.display();

  Person p2 = Person.fromJson({"name": "Ali", "age": 21, "gender": "male"});
  p2.display();
}
