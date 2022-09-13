import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_with_lara/screens/homa.dart';

import 'backend_helper.dart';
import 'package:http/http.dart' as http;

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  @override
  Widget build(BuildContext context) {
//variables
    String name = "";
    String email = "";
    // String rate = "";

// All Controllers
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    // TextEditingController rateController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    // Add data to databse

    Future<void> saveData(String name, String email) async {
      String url = 'http://10.0.2.2:8000/api/saved';
      Map<String, dynamic> JsonBody = {'name': name, 'email': email};
      try {
        http.Response resp = await http.post(Uri.parse(url), body: JsonBody);
        if (resp.statusCode == 200) {
          log("resp.statusCode = 200");
          return null;
        } else {
          log("bad sttatus code");
          return null;
        }
      } catch (error) {
        return Future.error(error);
      }
    }

    // Clear text
    clear() {
      nameController.clear();
      emailController.clear();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Add Data")),
      body: Form(
        key: formKey,
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
                errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
              ),
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter name";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "email",
                border: OutlineInputBorder(),
                errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
              ),
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter email";
                }
                return null;
              },
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      name = nameController.text.trim();
                      email = emailController.text.trim();
                      saveData(name, email);
                      clear();
                      setState(() {
                        Home();
                      });
                    });
                  }
                },
                child: const Text("Save Data")),
            ElevatedButton(
                onPressed: () {
                  clear();
                },
                child: const Text("Clear Data"))
          ])
        ]),
      ),
    );
  }
}
