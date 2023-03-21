class User {
  final int age;

  User({required this.age});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      age: json['dob']['age'], //extract the age from the 'dob' field in the json map
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{}; //convert user object to json map
    data['age'] = age;
    return data;
  }
}
