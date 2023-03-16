import 'package:flutter/material.dart';
import 'package:bmi_calculator/models/bmi_model.dart';
import 'package:bmi_calculator/data/database_helper.dart';

class ResultsScreen extends StatefulWidget {
  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  // define an empty list of results
  List<Result> results = [];

  // load the results from the database when the widget is initialized
  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  // function to load results from the database asynchronously
  Future<void> _loadResults() async {
    List<Result> loadedResults = await DatabaseHelper.instance.getResults();
    // update the state with the loaded results
    setState(() {
      results = loadedResults;
    });
  }

  //results screen widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      // display the list of results in a scrollable list view
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, int index) {
          Result result = results[index];
          return ListTile(
            leading: Text(result.id.toString()), // display the result id
            title: Text('BMI: ${result.bmi.toStringAsFixed(2)} (${result.status})'), //display bmi valie of result
            subtitle: Text('Weight: ${result.weight} | Height: ${result.height}'), // display the status of the result
            trailing: IconButton(
              icon: Icon(Icons.delete),
              // delete the result when the button is pressed
              onPressed: () async {
                int deletedRows =
                await DatabaseHelper.instance.deleteResult(result.id!);
                if (deletedRows > 0) {
                  // Refresh the results list
                  setState(() {
                    results.removeAt(index);
                  });
                  // Show a snackbar to indicate success
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Result ${result.id} deleted!')),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
