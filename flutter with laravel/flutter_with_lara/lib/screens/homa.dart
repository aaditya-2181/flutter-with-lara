import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'add_data.dart';
import 'backend_helper.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // getData() async {
  //   try {
  //     String url = 'http://10.0.2.2:8000/api/users';
  //     var resp = await http.get(Uri.parse(url));
  //     if (resp.statusCode == 200) {
  //       return jsonDecode(resp.body);
  //     } else {
  //       return Future.error("Server Error");
  //     }
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }
  // final Stream strim = getData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Home",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddData();
                  }));
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ))
          ],
        )),

        // body part
        body: SingleChildScrollView(
          child: StreamBuilder<List>(
            // stream: ,
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              // print(snapshot.toString());
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              // List Data form database
              if (snapshot.hasData) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  child: Table(
                    columnWidths: const <int, TableColumnWidth>{
                      1: FixedColumnWidth(140),
                    },
                    border: TableBorder.all(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid),
                    children: [
                      const TableRow(children: [
                        TableCell(
                          child: Center(
                            child: Text("NAME",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text("EMAIL",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              "Actions",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ]),

                      // List Data from database
                      for (var i = 0; i < snapshot.data!.length; i++) ...{
                        TableRow(children: [
                          // name column
                          TableCell(
                            child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 2),
                                child:
                                    Text(snapshot.data![i]['name'].toString())),
                          ),

                          // email column
                          TableCell(
                            child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Text(
                                    snapshot.data![i]['email'].toString())),
                          ),

                          // Action icon
                          TableCell(
                              child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          )),
                        ])
                      }
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text("No data Found"),
                );
              }
            },
          ),
        ));
  }
}
