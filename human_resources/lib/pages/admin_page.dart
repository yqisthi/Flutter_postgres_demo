import 'package:flutter/material.dart';
import 'package:human_resources/components/create_data_dialog.dart';
import 'package:human_resources/components/edit_data_dialog.dart';
import 'package:human_resources/components/profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminPage extends StatefulWidget {
  final String name;
  final String role;
  const AdminPage({required this.name, required this.role});
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Map<String, dynamic>> dataList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final String apiUrl = 'http://localhost:8080/getalldata';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        setState(() {
          dataList = List<Map<String, dynamic>>.from(data);
        });
      } else {
        // Handle error cases
        print('Error: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
    }
  }

  void deleteData(String email) async {
    final String apiUrl = 'http://localhost:8080/deletedata?email=$email';

    try {
      final response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Update the UI or re-fetch data after successful deletion
        fetchData();
      } else {
        // Handle error cases
        print('Error: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
    }
  }

  Future<void> _showCreateDataDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateDataDialog(
          onCreate: (String email, String name, String password, String role) {
            // Call the createData function with the entered data
            createData(email, name, password, role);
          },
        );
      },
    );
  }

  Future<void> createData(
    String email,
    String name,
    String password,
    String role,
  ) async {
    final String apiUrl = 'http://localhost:8080/createdata';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'email': email,
          'name': name,
          'password': password,
          'role': role,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        // Update the UI or re-fetch data after successful creation
        fetchData();
      } else {
        // Handle error cases
        print('Error: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
    }
  }

  Future<void> _showEditDataDialog(
    String email,
    String nameText,
    String passwordText,
    String roleText,
  ) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditDataDialog(
          emailParam: email,
          emailText: email,
          nameText: nameText,
          passwordText: passwordText,
          roleText: roleText,
          onUpdate: (String emailParam, String emailUpdated, String name,
              String password, String role) {
            // Call the updateData function with the entered data
            updateData(emailParam, emailUpdated, name, password, role);
          },
        );
      },
    );
  }

  Future<void> updateData(
    String emailParameter,
    String updatedEmail,
    String name,
    String password,
    String role,
  ) async {
    final String apiUrl =
        'http://localhost:8080/updatedata?email=$emailParameter';

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'email': updatedEmail,
          'name': name,
          'password': password,
          'role': role,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Update the UI or re-fetch data after successful update
        fetchData();
      } else {
        // Handle error cases
        print('Error: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Profile(name: widget.name, role: widget.role),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 400, // Adjust the height as needed
              child: dataList.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        final data = dataList[index];
                        return ListTile(
                          title: Text('Name: ${data['name']}'),
                          subtitle: Text('Role: ${data['role']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _showEditDataDialog(
                                      data['email'],
                                      data['name'],
                                      data['password'],
                                      data['role']);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  deleteData(data['email']);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: IconButton(
                icon: Icon(Icons.add_box_rounded),
                onPressed: _showCreateDataDialog),
          )
        ],
      ),
    );
  }
}
