import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AmadeusUtility {
  static String _authKey = '';
  static Future<String> getAmadeusAuthKey() async {
    var url = Uri.https('test.api.amadeus.com', '/v1/security/oauth2/token');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body:
            'grant_type=client_credentials&client_id=bcpnSZFwccsF5h1Ye2yE0JRDLlXQnUP5&client_secret=ganPB3JzdF7atTQY');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var responseObject = jsonDecode(response.body);
    String authKey = responseObject['access_token'];
    _authKey = authKey;
    return authKey;
  }

  static Future<List<String>> getAmadeusAirports(String keyword) async {
    var url = Uri.https('test.api.amadeus.com', '/v1/reference-data/locations',
        {'subType': 'AIRPORT', 'keyword': keyword, 'view': 'FULL'});
    var response = await http
        .get(url, headers: {'Authorization': 'Bearer ' + _authKey + ''});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var responseObject = jsonDecode(response.body);
      print(responseObject);

      List responseData = responseObject['data'];
      List<String> airports = [];
      for (var item in responseData) {
        airports.add(item['name'] as String);
      }
      print(airports);
      return airports;
    } else {
      return [];
    }
  }
}
