// function that sends a string to a google cloud function via https post request with https://us-central1-aitripplanner-9890b.cloudfunctions.net/openai with the json {"input": "string"}


import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> triggerCloudFunction(String input) async {
  final Uri uri = Uri.parse('https://us-central1-aitripplanner-9890b.cloudfunctions.net/openai');
  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'input': input}),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to trigger cloud function');
  }
}

void main() async {
  try {
    String input = 'I would like to go to Amsterdam';
    String result = await triggerCloudFunction(input);
    print('Result: $result');
  } catch (e) {
    print('Error: $e');
  }
}