import 'package:http/http.dart' as http;
import 'dart:convert';

class ExerciseApi {
  static const String _baseUrl =
      'https://exercises-by-api-ninjas.p.rapidapi.com/v1/exercises';
  static const String _apiKey =
      'e07a48862amsh532f859f05cb1a3p1d6ec4jsnf4a6e172f5f1';

  static Future<List<dynamic>> fetchExercises(String muscle) async {
    final url = Uri.parse('$_baseUrl?muscle=$muscle');
    final response = await http.get(url, headers: {
      'X-RapidAPI-Key': _apiKey,
      'X-RapidAPI-Host': 'exercises-by-api-ninjas.p.rapidapi.com',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      print('Failed to fetch exercises.');
      // Return an empty list to handle the error gracefully
      return [];
    }
  }
}
