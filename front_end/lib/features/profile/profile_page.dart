import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:genix_auctions/core/shared_preference.dart';
import 'package:genix_auctions/features/homepage/presentation/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  String userId = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      final response = await http.get(
        Uri.parse('http://localhost:3000/api/v1/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        print(userData);
        setState(() {
          email = userData['_id'];
          nameController.text = userData['name'];
          contactController.text = userData['contact'];
          ageController.text = userData['age'].toString();
          genderController.text = userData['gender'];
        });
      } else {
        throw Exception('Failed to load profile');
      }
    }
  }

  Future<void> _updateUserProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      final response = await http.put(
        Uri.parse('http://localhost:3000/api/v1/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode(<String, dynamic>{
          'name': nameController.text,
          'contact': contactController.text,
          'age': int.parse(ageController.text),
          'gender': genderController.text,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Profile updated successfully'),
        ));
      } else {
        throw Exception('Failed to update profile');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.amberAccent,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                      ),
                      TextField(
                        controller: contactController,
                        decoration: const InputDecoration(labelText: 'Contact'),
                      ),
                      TextField(
                        controller: ageController,
                        decoration: const InputDecoration(labelText: 'Age'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: genderController,
                        decoration: const InputDecoration(labelText: 'Gender'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _updateUserProfile,
                        child: const Text('Update Profile'),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: Text('My Bids'),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: Text('My Auctions'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await clearUserCredentials()
                              .whenComplete(() => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MyHomePage(title: "title"),
                                    ),
                                  ));
                        },
                        child: const Text('Sign out'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
