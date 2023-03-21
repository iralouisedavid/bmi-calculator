# Changelog

## Version 1.0.0 - 2023-03-16
* Initial release of the app.

## Version 1.1.0 - 2023-03-17
* Added the ability to generate random input value for age using the RandomUser API by clicking on the "Generate Age" button.
* Added an API service to retrieve random user data from the RandomUser API.
* Created separate validators file to handle form field validations.
* Fixed minor bugs and improved overall app performance.
* Enhanced code readability and maintainability by adding comments.

## Version 1.2.0 - 2023-03-21
* Modified api.dart to fetch random user data from the Random User API using a separate function that returns a User object instead of returning data directly.
* Created a separate user.dart file to define the User class.
* Replaced setState() with a ValueNotifier to update the UI when the age is generated.
* Updated the code to fetch a random user age from the API and display it in the UI using a ValueNotifier.
* Added a ValueNotifier to hold the list of results in the ResultsScreen widget.
* Utilized AnimatedBuilder to rebuild the ListView only when the ValueNotifier is changed, boosting performance and reducing needless rebuilds.
* Modified the _loadResults() function to update the ValueNotifier instead of calling setState(), improving separation of concerns and reducing unnecessary rebuilds.
* Enhanced code readability and maintainability by adding more comments.