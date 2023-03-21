import 'package:flutter/material.dart';
import 'package:bmi_calculator/bmi_calculator.dart';
import 'package:bmi_calculator/screens/bmi_results_screen.dart';
import 'package:bmi_calculator/screens/bmi_settings_screen.dart';
import 'package:bmi_calculator/validators/bmi_validators.dart';
import 'package:bmi_calculator/services/api.dart';
import 'package:bmi_calculator/models/user.dart';

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

  // Create ValueNotifier for age
  ValueNotifier<int> _ageValueNotifier = ValueNotifier<int>(0);

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
                MaterialPageRoute(builder: (context) => const BMISettingsScreen()),
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
              validator: validateWeight,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
              validator: validateHeight,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              validator: validateAge,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BMICalculator bmiCalculator = BMICalculator(
                    weight: double.parse(_weightController.text),
                    height: double.parse(_heightController.text),
                    //age: int.parse(_ageController.text),
                    age: _ageValueNotifier.value, // Use the value from ValueNotifier
                  );
                  bmiCalculator.displayBMIResult(context);// Call displayBMIResult method here
                }
              },
              child: const Text('Calculate BMI'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  User user = await Api.getRandomUserData(); // Fetch data from API
                  _ageValueNotifier.value = user.age; // Update ValueNotifier with fetched age
                  _ageController.text = _ageValueNotifier.value.toString(); // Set age text field with the new age value

                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Generated age successfully!'),
                      backgroundColor: Colors.lightGreen,
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to generate age'),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              child: const Text('Generate Age'),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
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


