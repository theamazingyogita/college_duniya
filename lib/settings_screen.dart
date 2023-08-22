import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        children: const [
          Text(
            "Update Profile",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
            ),
          ),
          Text(
            "Change Theme",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
            ),
          ),
          Text(
            "LogOut",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
