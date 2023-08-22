// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:collage_duniya/profile_screen.dart';
import 'package:collage_duniya/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  dynamic name = '';
  dynamic email = '';

  @override
  void initState() {
    getProfileInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 3.0,
        sigmaY: 3.0,
      ),
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(24.0),
          ),
        ),
        backgroundColor: Colors.indigo,
        //   backgroundColor: const Color(0xFFC5D9FF).withOpacity(1),
        child: Flex(
          direction: Axis.vertical,
          children: [
            SizedBox(
                height: 250.0,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(30.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          name[0].toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(height: 12.0),
                    Text(
                      name,
                      // "Yogita Agarwal",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileDetailScreen(),
                  ),
                );
              },
              style: ListTileStyle.drawer,
              title: const Text(
                "Update Profile",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              leading: const Icon(
                Icons.account_circle_outlined,
                size: 30.0,
                color: Colors.white,
              ),
            ),
            ListTile(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                );
              },
              style: ListTileStyle.drawer,
              title: const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              leading: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getProfileInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString("kUserEmail") ?? '';
      name = prefs.getString("kUserName") ?? '';
    });
  }
}
