import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'util.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isSendingCode = false;
  int secondsRemaining = 0;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  Future<void> sendCode() async {
    if(usernameController.text.isEmpty || emailController.text.isEmpty) {
      showMessage("Account and email cannot be empty.");
      return;
    }
    setState(() {
      isSendingCode = true;
      secondsRemaining = 60;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        secondsRemaining--;
        if (secondsRemaining <= 0) {
          t.cancel();
          isSendingCode = false;
        }
      });
    });
    // TODO:
    await Future.delayed(const Duration(seconds: 1));
    showMessage("Verification code has been sent. Please check your email.");
  }

  Future<void> resetPassword() async {
    final username = usernameController.text;
    final email = emailController.text;
    final vCode = codeController.text;
    final password = passwordController.text;
    if(username.isEmpty || email.isEmpty || vCode.isEmpty || password.isEmpty) {
      showMessage("All fields must be filled in.");
      return;
    }
    String encryptedPwd = AESUtil.encrypt(password);
    //var url = Uri.parse("http://10.0.2.2:8000/register");
    // set the inner IP of server's pc
    var url = Uri.parse("http://192.168.3.6:8000/reset_password");
    var res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": encryptedPwd,
        "email": email,
        "code": vCode
      }),
    );
    if (!mounted) return;
    var data = jsonDecode(res.body);
    int code = data["code"];
    String message = data["message"];
    if (code == 200) {
      showMessage("Reset password Success!");
      Navigator.pop(context);
    } else {
      showMessage(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forget Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Account"),
            ),
            const SizedBox(height: 16,),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "Please enter the email address you have linked.",
              ),
            ),
            const SizedBox(height: 16,),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: codeController,
                    decoration: const InputDecoration(labelText: "Verification code"),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed:
                  isSendingCode ? null : () => sendCode(),
                  child: Text(
                    isSendingCode ? "$secondsRemaining s" : "Get Code",
                  ),
                )
              ],
            ),
            const SizedBox(height: 16,),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "New Password"),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: resetPassword,
                  child: const Text("Confirm"),
              ),
            )
          ],
        ),
      ),
    );
  }

}