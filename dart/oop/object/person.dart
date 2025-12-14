enum Gender { male, female, other }

class Person {
  // attr.
  String? name;
  int? age;
  Gender? gender;

  Person({required this.name, required this.age, required this.gender});
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(name: json["name"], age: json["age"], gender: json["gender"]);
  }

  // methods.
  void display() {
    print("name : $name, age : $age, gender : $gender");
  }

  void display1([String? phone]) {
    print("name : $name, age : $age, gender : $gender, ");
  }
}

//
// {
//   "name": "Ahmed",
//   "age": 20,
//   "gender": "male"
//}

// map["data"][0]["name"];
// data[0].;
