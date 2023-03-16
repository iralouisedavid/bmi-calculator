import 'package:flutter/material.dart';
import 'screens/bmi_calculator_screen.dart';
import 'package:bmi_calculator/themes/theme.dart';
import 'package:provider/provider.dart';

// void main() => runApp(BMICalculator(
// ));

void main() => runApp(
  ChangeNotifierProvider(
    create: (_) => ThemeNotifier(),
    child: BMICalculator(),
  ),
);

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: Provider.of<ThemeNotifier>(context).darkTheme ? dark : light,
      home: BMICalculatorScreen(),
    );
  }
}