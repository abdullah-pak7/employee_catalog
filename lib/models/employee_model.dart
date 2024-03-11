class Employee {
  final int id;
  final String name;
  final String contact;
  final int age;

  Employee({required this.id, required this.name, required this.contact, required this.age});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['firstName'] + " " +json['lastName'],
      contact: json['contactNumber'],
      age: json['age'],
    );
  }
}