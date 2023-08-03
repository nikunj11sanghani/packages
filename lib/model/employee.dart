class Employee {
  final int id;
  final String name;
  final int age;

  const Employee({
    required this.id,
    required this.name,
    required this.age,
  });

  factory Employee.frmJson(Map<String, dynamic> json) =>
      Employee(id: json['id'] ?? 0, name: json['name'], age: json['age']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "age": age,
      };
}
