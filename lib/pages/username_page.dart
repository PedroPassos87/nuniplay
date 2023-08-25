class UserModel {
  final String? id;
  final String name;
  final String username;
  final int age;
  final String college;
  final String email;
  final String password;

  const UserModel({
    this.id,
    required this.name,
    required this.username,
    required this.college,
    required this.age,
    required this.email,
    required this.password,
  });

  toJson() {
    return {
      "name": name,
      "username": username,
      "age": age,
      "college": college,
      "email": email,
      "password": password,
    };
  }
}
