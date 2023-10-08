import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Pages/Shared/Blocs/globals.dart';

class AuthServices {
  static Future<http.Response> register(
      String name, String email, String password) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url =
        Uri.parse('${baseURL}auth/register'); //trocar pela rota do laravel
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    debugPrint(response.body);
    return response;
  }

  static Future<http.Response> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse('${baseURL}auth/login'); //trocar pela rota do laravel
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    debugPrint(response.body);
    return response;
  }
}