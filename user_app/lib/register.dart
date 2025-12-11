import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'util.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pswController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _register() async {
    var username = _accountController.text.trim();
    var email = _emailController.text.trim();
    var pwd = _pswController.text.trim();
    var confirm = _confirmController.text.trim();
    if(username.isEmpty || email.isEmpty || pwd.isEmpty || confirm.isEmpty) {
      showMessage("The parameters cannot be empty.");
    }
    if (pwd != confirm) {
      if (!mounted) return;
      showMessage("Passwords do not match.");
      return;
    }
    String encryptedPwd = AESUtil.encrypt(pwd);
    //var url = Uri.parse("http://10.0.2.2:8000/register");
    // set the inner IP of server's pc
    var url = Uri.parse("http://192.168.3.6:8000/register");
    var res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": encryptedPwd
      }),
    );
    if (!mounted) return;
    var data = jsonDecode(res.body);
    int code = data["code"];
    String message = data["message"];
    if (code == 200) {
      showMessage("Register Success!");
      Navigator.pop(context);
    } else {
      showMessage(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextField(
                controller: _accountController,
                decoration: const InputDecoration(
                  labelText: "Account",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16,),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16,),
              TextField(
                controller: _pswController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16,),
              TextField(
                controller: _confirmController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Confirm Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _register,
                  child: const Text("Register"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}