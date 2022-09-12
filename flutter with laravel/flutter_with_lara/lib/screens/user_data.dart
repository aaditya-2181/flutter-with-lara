import 'dart:convert';

import 'package:http/http.dart' as http;

class UserData {
  String url = 'http://10.0.2.2:8000/api/users';
  Future<List> getData() async {
    try {
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
}
