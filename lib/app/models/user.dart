class User {
  String? username;
  String? email;
  String? password;
  User({required this.username, required this.email, required this.password});
  User.instance(this.email, this.password);

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }

  static User fromMap(Map<String, dynamic> json) {
    return User(
        username: json['username'],
        email: json['email'],
        password: json['password']);
  }
}
