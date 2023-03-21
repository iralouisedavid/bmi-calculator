import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/bmi_calculator_screen.dart';
import 'screens/bmi_results_screen.dart';
import 'package:bmi_calculator/themes/theme.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      // Provider for managing the app's theme
      ChangeNotifierProvider(create: (_) => ThemeNotifier()),
    ],
    child: BMICalculator(),
  ),
);

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: Provider.of<ThemeNotifier>(context).darkTheme ? dark : light, // Set the app theme based on the current theme value in the ThemeNotifier
      initialRoute: '/',
      routes: {
        '/': (context) => BMICalculatorScreen(), // Route to the BMI calculator screen
        '/results': (context) => ResultsScreen(), // Route to the BMI results screen
      },
    );
  }
}




















//
// // void main() => runApp(BMICalculator(
// // ));
//
// void main() => runApp(
//   ChangeNotifierProvider(
//     create: (_) => ThemeNotifier(),
//     child: BMICalculator(),
//   ),
// );
//
// class BMICalculator extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'BMI Calculator',
//       theme: Provider.of<ThemeNotifier>(context).darkTheme ? dark : light,
//       home: BMICalculatorScreen(),
//     );
//   }
// }