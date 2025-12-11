import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'util.dart';
import 'register.dart';
import 'forget.dart';
import 'home.dart';
import 'config.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _pswController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _accountController.dispose();
    _pswController.dispose();
    super.dispose();
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _goRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegisterPage()),
    );
  }

  void _goForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
    );
  }

  void _login() async {
    // Future: implement login logic
    final username = _accountController.text;
    final password = _pswController.text;
    if(username.isEmpty || password.isEmpty) {
      showMessage("The parameters cannot be empty.");
      return;
    }
    String encryptedPwd = AESUtil.encrypt(password);
    //var url = Uri.parse("http://10.0.2.2:8000/register");
    // set the inner IP of server's pc
    var url = Uri.parse("${AppConfig.instance.baseUrl}/login");
    var res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": encryptedPwd
      }),
    );
    if (!mounted) return;
    var data = jsonDecode(res.body);
    int code = data["code"];
    String message = data["message"];
    if (code == 200) {
      final dat = data["data"];
      AppConfig.instance.token = dat["token"];
      AppConfig.instance.userId = dat["user_id"].toString();
      AppConfig.instance.userName = username;
      showMessage("Login Success!");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()));
    } else {
      showMessage(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _accountController,
                decoration: const InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _pswController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _goForgotPassword,
                    child: const Text("Forgot Password?"),
                  ),
                  TextButton(
                    onPressed: _goRegister,
                    child: const Text("Register"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _login,
                  child: const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}