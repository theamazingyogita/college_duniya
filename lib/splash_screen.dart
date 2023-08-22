import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'college_list_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: (5)),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Lottie.asset(
          'assets/splash.json',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          controller: _controller,
          animate: true,
          onLoaded: (composition) async {
            _controller
              ..duration = composition.duration * 3
              ..forward().whenComplete(
                () async {
                  await isUserLoggedIn()
                      ? Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CollegeListScreen()))
                      : Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                },
              );
          },
        ),
        const Center(
          child: Text(
            "Welcome",
            style: TextStyle(
              fontSize: 32.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ));
  }

  Future<bool> isUserLoggedIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return Future.value(prefs.getBool("kStayLogin") ?? false);
    } catch (error) {
      return false;
    }
  }
}
