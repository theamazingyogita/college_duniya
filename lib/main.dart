import 'package:collage_duniya/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        backgroundColor: const Color(0xFFFAFAFA),
        textTheme: const TextTheme(),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      home: const SplashScreen(),
    ),
  );
}
