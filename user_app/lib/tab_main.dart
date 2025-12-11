import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  String _username = "Liao Junxin";
  String _email = "liaoAssin1987@gmail.com";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    var user = await fetchUser();
    if (user != null && mounted) {
      setState(() {
        _username = user["username"];
        _email = user["email"];
      });
    }
  }

  Future<Map<String, dynamic>?> fetchUser() async {
    final url = Uri.parse("${AppConfig.instance.baseUrl}/get_user");
    final res = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${AppConfig.instance.token}",
      },
    );
    final data = jsonDecode(res.body);
    if (data["code"] == 200) {
      return data["data"];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.lightBlue.shade100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 70,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    _username,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _email,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "I want more than just a job; I want a place where my skills and ideas can create real value.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.4,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: 100,
              height: 2,
              color: Colors.lightBlue.shade200,
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "With over a decade of Android development across e-commerce, energy monitoring, IoT, and education, "
                    "I bring the ability to independently build complete applications on both Android and Flutter. "
                    "I’m self-taught in Python and Web technologies, and I’m currently exploring AI-driven automation to improve workflow efficiency. "
                    "I also collaborate with a hardware partner in China, with active interests in energy technology and hydroponic systems.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
