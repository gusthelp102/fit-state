import 'dart:convert';

import 'package:http/http.dart' as http;

class BmiApi {
  static const String baseUrl =
      'https://body-mass-index-bmi-calculator.p.rapidapi.com/metric';
  static const Map<String, String> headers = {
    'X-RapidAPI-Key': 'e07a48862amsh532f859f05cb1a3p1d6ec4jsnf4a6e172f5f1',
    'X-RapidAPI-Host': 'body-mass-index-bmi-calculator.p.rapidapi.com',
  };

  static Future<double?> calculateBmi(String weight, String height) async {
    final Map<String, String> params = {'weight': weight, 'height': height};
    final Uri uri = Uri.parse(baseUrl).replace(queryParameters: params);

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return double.tryParse(responseData['bmi']?.toString() ?? '');
    } else {
      return null;
    }
  }
}
