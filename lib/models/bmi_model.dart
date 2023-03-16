import 'package:sqflite/sqflite.dart';

class Result {
  //define the data that will be stored in the database
  final int? id;
  final double weight;
  final double height;
  final int age;
  final double bmi;
  final String status;

  Result({
    this.id,
    required this.weight,
    required this.height,
    required this.age,
    required this.bmi,
    required this.status,
  });

  //Convert bmi object to map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'weight': weight,
      'height': height,
      'age': age,
      'bmi': bmi,
      'status': status,
    };
  }

  //method to get values from other fields while auto-incrementing the id
  Map<String, dynamic> toMapWithoutId() {
    return {
      'age': age,
      'weight': weight,
      'height': height,
      'bmi': bmi,
      'status': status,
    };
  }


  static Result fromMap(Map<String, dynamic> map) {
    return Result(
      id: map['id'],
      weight: map['weight'],
      height: map['height'],
      age: map['age'],
      bmi: map['bmi'],
      status: map['status'],
    );
  }

}