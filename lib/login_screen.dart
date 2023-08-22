import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'college_list_screen.dart';
import 'constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  dynamic _nameError;
  dynamic _emailError;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_clearNameError);
    _emailController.addListener(_clearEmailError);
  }

  @override
  void dispose() {
    _nameController.removeListener(_clearNameError);
    _emailController.removeListener(_clearEmailError);
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _clearNameError() {
    setState(() {
      _nameError = null;
    });
  }

  void _clearEmailError() {
    setState(() {
      _emailError = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Lottie.asset(
                  "assets/login.json",
                ),
                const SizedBox(height: 20),
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.indigo,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.4,
                        color: Colors.indigoAccent,
                      ),
                    ),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.indigo,
                      ),
                    ),
                    focusColor: Colors.indigoAccent,
                    prefixIcon: const Icon(
                      Icons.account_circle_rounded,
                      color: Colors.indigo,
                    ),
                    labelText: 'Name',
                    errorText: _nameError,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.indigo,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.4,
                        color: Colors.indigoAccent,
                      ),
                    ),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.indigo,
                      ),
                    ),
                    focusColor: Colors.indigoAccent,
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.indigo,
                    ),
                    labelText: 'Email',
                    errorText: _emailError,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 48),
                ElevatedButton.icon(
                  onPressed: () =>
                      _loginUser(_emailController.text, _nameController.text),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(40),
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                  label: const Text(
                    'Login',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  icon: const Icon(
                    Icons.login_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginUser(String email, String name) async {
    if (_validateEmail(email) && _validateName(name)) {
      SharedPreferences pref = await SharedPreferences.getInstance();

      pref.setString(kUserEmail, _emailController.text);
      pref.setString(kUserName, _nameController.text);

      pref.setBool("kStayLogin", true).then((value) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const CollegeListScreen(),
        ));
      });
    } else {
      setState(() {
        _emailError =
            _validateEmail(email) ? null : 'Please enter a valid email';
        _nameError = _validateName(name) ? null : 'Please enter your name';
      });
    }
  }

  bool _validateEmail(String email) {
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  bool _validateName(String name) {
    return name.isNotEmpty;
  }
}
