import 'person.dart';

main() {
  Student s1 = Student(id: '2332123', grade: 'A', name: "Ahmed");
  s1.display();

  Doctor d1 = Doctor(id: '2332123', name: "Ahmed", salary: 20000);
  d1.display();
}
