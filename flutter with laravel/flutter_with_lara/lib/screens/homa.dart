import 'package:flutter/material.dart';
import 'package:flutter_with_lara/screens/user_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserData userData = UserData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Home")),
        body: FutureBuilder<List>(
          future: userData.getData(),
          builder: (context, snapshot) {
            print(snapshot.toString());
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          snapshot.data![i]['name'],
                          // snapshot[i]['name'].toString(),
                          style: const TextStyle(fontSize: 22),
                        ),
                        subtitle: Text(snapshot.data![i]['email'],
                            style: const TextStyle(fontSize: 18)),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: Text("No data Found"),
              );
            }
          },
        ));
  }
}
