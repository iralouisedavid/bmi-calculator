import 'package:flutter/material.dart';
import 'package:bmi_calculator/bmi_calculator.dart';
import 'package:bmi_calculator/screens/bmi_results_screen.dart';
import 'package:bmi_calculator/screens/bmi_settings_screen.dart';

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  // Create controllers for text fields
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  // Create a form key to validate input
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BMISettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            TextFormField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter your weight in kilograms';
                }
                double? weight = double.tryParse(value);
                if (weight == null || weight < 2 || weight > 650) {
                  return 'Please enter a valid weight';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter your height in centimeters';
                }
                double? height = double.tryParse(value);
                if (height == null || height < 50 || height > 280) {
                  return 'Please enter a valid height';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your age';
                }
                int? age = int.tryParse(value);
                if (age == null || age < 1 || age > 110) {
                  return 'Please enter a valid age';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BMICalculator bmiCalculator = BMICalculator(
                    weight: double.parse(_weightController.text),
                    height: double.parse(_heightController.text),
                    age: int.parse(_ageController.text),
                  );
                  bmiCalculator.displayBMIResult(context); // Call displayBMIResult method here
                }
              },
              child: const Text('Calculate BMI'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  // navigateResultsPage(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResultsScreen()),
                  );
                },
                child: const Text('View Results'),
            ),
          ],
        ),
      ),
    );
  }
}


