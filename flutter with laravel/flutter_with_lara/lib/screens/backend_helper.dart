import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DatabaseOperations {
  // get data
  Future<List> getData() async {
    try {
      String url = 'http://10.0.2.2:8000/api/users';
      var resp = await http.get(Uri.parse(url));
      if (resp.statusCode == 200) {
        return jsonDecode(resp.body);
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  // save data
  Future saveData(String name, String email) async {
    String url = 'http://127.0.0.1:8000/api/saved';
    Map<String, dynamic> JsonBody = {'name': name, 'email': email};

    http.Response resp = await http.post(Uri.parse(url), body: JsonBody);
    if (resp.statusCode == 200) {
      return "Data saved";
    } else {
      return "not saved";
    }
    // try {
    //   if (resp.statusCode == 200) {
    //     return "Data saved";
    //   } else {
    //     return "Data not saved";
    //   }
    // } catch (error) {
    //   return Future.error(error);
    // }
  }

  // update data
  Future updateData(int? id, String? name, String? email) async {
    try {
      String url =
          'http://127.0.0.1:8000/api/update?id=$id&name=$name&email=$email';
      var resp = await http.put(Uri.parse(url));
      if (resp.statusCode == 200) {
        return "Data updated";
      } else {
        return "Data was not updated";
      }
    } catch (error) {
      return Future.error(error);
    }
  }
}
