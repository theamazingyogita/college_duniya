// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _loadProfileData(); // Load profile data when the page is initialized
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: const Text(
          'Profile Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Flex(
            direction: Axis.vertical,
            children: [
              const SizedBox(height: 36.0),
              const Icon(
                Icons.account_circle_rounded,
                color: Colors.indigo,
                size: 136.0,
              ),
              const SizedBox(height: 36.0),
              TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 16),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 1.6,
                  )),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 1.6,
                  )),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 1.6,
                  )),
                  disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 1.6,
                  )),
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                maxLength: 30,
              ),
              const SizedBox(height: 24.0),
              TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 16),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 1.6,
                  )),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 1.6,
                  )),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 1.6,
                  )),
                  disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.indigo,
                    width: 1.6,
                  )),
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 48.0),
              ElevatedButton(
                onPressed: () {
                  _saveProfileData(); // Save the updated profile data
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    fixedSize: Size(MediaQuery.of(context).size.width, 40.0)),
                child: const Text(
                  "Update",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? name = prefs.getString('kUserName');
    String? email = prefs.getString('kUserEmail');
    setState(() {
      _nameController.text = name ?? '';
      _emailController.text = email ?? '';
    });
  }

  void _saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('kUserName', _nameController.text);
    await prefs.setString('kUserEmail', _emailController.text);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Profile data saved successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'OK',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
