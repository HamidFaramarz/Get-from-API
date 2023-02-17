import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// api sources
// https://reqres.in/

// Steps
// 1. add packages to dependency
// 2. import .....
// 3. make fetch function
// 4. Use function

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fetch Data From API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic>? _userProfile;

// start of fetch function
  Future<void> _fetchData() async {
    var response =
        await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    final data = jsonDecode(response.body);
    setState(() {
      _userProfile = data['data'];
    });
  }

// end of fetch function

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  Widget _userList() {
    if (_userProfile == null) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: _userProfile!.length,
      itemBuilder: (context, index) {
        final userProfile = _userProfile![index];
        return Card(
          color: Color.fromARGB(255, 132, 175, 194),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(userProfile['avatar']),
            ),
            trailing: Text("${userProfile['id']}"),
            title: Text(
                "${userProfile['first_name']} - ${userProfile['last_name']}"),
            subtitle: Text("${userProfile['email']}"),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 53, 56, 215),
        centerTitle: true,
        title: const Text('Users List'),
      ),
      body: _userList(),
    );
  }
}
