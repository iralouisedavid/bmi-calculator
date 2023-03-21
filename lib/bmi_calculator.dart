import 'package:flutter/material.dart';
import 'package:bmi_calculator/models/result.dart';
import 'package:bmi_calculator/data/database_helper.dart';

class BMICalculator extends ChangeNotifier {
  //instance variables
  final double weight;
  final double height;
  final int age;
  late double _bmi;
  late String status;

  //Constructor w/ named parameters
  BMICalculator({
    required this.weight,
    required this.height,
    required this.age,
  }) {
    calculateBMI();
  }

  // Create a DatabaseHelper object to perform database operations
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  // Calculate BMI based on weight, height and age*
  void calculateBMI() {
    _bmi = weight / ((height / 100) * (height / 100));
    status = getBMIStatus();
  }

  // Get the BMI result (status)
  String getBMIStatus() {
    if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi > 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  // Get the color of the BMI result
  Color getBMIStatusColor() {
    if (_bmi >= 25) {
      return Colors.red; //overweight
    } else if (_bmi > 18.5) {
      return Colors.blue; //normal
    } else {
      return Colors.yellow; //underweight
    }
  }

  // Display the BMI result in a dialog box
  Future<void> displayBMIResult(BuildContext context) async {
    Result bmiResult = Result(
      age: age,
      weight: weight,
      height: height,
      bmi: _bmi,
      status: status,
    );
    await databaseHelper.insertResult(bmiResult);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('BMI Result'),
          content: Text(
            'BMI: ${_bmi.toStringAsFixed(1)}\n''Status: $status',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: getBMIStatusColor(),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
