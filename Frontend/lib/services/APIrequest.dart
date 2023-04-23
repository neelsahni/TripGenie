// function that sends a string to a google cloud function via http post request

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> sendRequest(String request) async {
  var url = Uri.parse('https://us-central1-ai-trip-planner.cloudfunctions.net/ai-trip-planner');
  var response = await http.post(url, body: jsonEncode({'request': request}));
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  return response.body;
}