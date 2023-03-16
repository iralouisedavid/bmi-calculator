import 'package:flutter/material.dart';
import 'package:bmi_calculator/themes/theme.dart';
import 'package:provider/provider.dart';

class BMISettingsScreen extends StatefulWidget {
  const BMISettingsScreen({Key? key}) : super(key: key);

  @override
  State<BMISettingsScreen> createState() => _BMISettingsScreenState();
}

class _BMISettingsScreenState extends State<BMISettingsScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Consumer<ThemeNotifier>(
                builder: (context, notifier, child) =>
                    SwitchListTile(
                        title: Text('Dark Mode'),
                        onChanged: (val){
                          notifier.toggleTheme();
                        },
                    value: notifier.darkTheme),
            ),
          ],
        )
      ),
    );
  }
}
