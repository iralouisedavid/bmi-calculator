import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bmi_calculator/models/user.dart';

class Api {
  static const String _baseUrl = 'https://randomuser.me/api/';

  static Future<User> getRandomUserData() async { // fetch random user data from the Random User API
    final url = Uri.parse(_baseUrl); //parse base url to uri
    final response = await http.get(url); //send GET request to url and wait for response

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body); //decode th response body from json
      final results = jsonResponse['results'][0];
      return User.fromJson(results); //convert result object to user object and return it
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }
}






// class Api {
//   static const String _baseUrl = 'https://randomuser.me/api/';
//
//   static Future<User> getRandomUserData() async { // fetch random user data from the Random User API
//     //String apiUrl = '$_baseUrl?inc=dob,weight,height&noinfo';
//     String apiUrl = '$_baseUrl?inc=dob'; // Construct the API URL
//
//     try {
//       http.Response response = await http.get(Uri.parse(apiUrl)); // Make the API request using the http package
//       dynamic decodedData = json.decode(response.body)['results'][0]; // Decode the response JSON
//       User user = User.fromJson(decodedData['dob']);
//       return user;
//
//     } catch (e) {
//       throw Exception('Failed to load random user data: $e');
//     }
//   }
// }