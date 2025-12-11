import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Map<String, dynamic>? profile;

  Future<void> loadProfile() async {
    final data = await rootBundle.loadString('assets/about.json');
    setState(() => profile = json.decode(data));
  }

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    if (profile == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitle("Basic Information"),
            basicInfoCard(),
            const SizedBox(height: 10),
            buildTitle("Skills"),
            skillsCard(),
            const SizedBox(height: 10),
            buildTitle("Languages"),
            folderCard("languages"),
            const SizedBox(height: 10),
            buildTitle("Education"),
            educationCard(),
            const SizedBox(height: 10),
            buildTitle("Advantages"),
            folderCard("advantages"),
            const SizedBox(height: 10),
            buildTitle("Work experience"),
            workExperienceCard(),
            const SizedBox(height: 10),
            buildTitle("Projects"),
            projectsCard(),
          ],
        ),
      ),
    );
  }

  Widget buildTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget buildText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    );
  }

  Widget projectsCard() {
    final raw = profile!["projects"];
    if (raw is! List) {
      return const Text("Projects data format error");
    }
    final list = raw.cast<Map<String, dynamic>>();
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: list.map((p) {
              final name = p["name"] ?? "Unnamed Project";
              final summary = p["summary"] ?? "";
              final duty = p["duty"] ?? "";
              final result = p["result"] ?? "";
              final techList = p["tech"] ?? [];
              final tech = (techList is List)
                  ? techList.join(", ")
                  : techList.toString();
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text("Summary: $summary"),
                    Text("Duty: $duty"),
                    Text("Result: $result"),
                    Text("Tech: $tech"),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget workExperienceCard() {
    final list = profile!["work"] as List<dynamic>;
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: list.map((work) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(work["company"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(work["period"]),
                    Text(work["role"]),
                    Text(work["desc"]),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget educationCard() {
    final list = profile!["education"] as List<dynamic>;
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: list.map((edu) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${edu["period"]}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("${edu["school"]} - ${edu["major"]}"),
                  const SizedBox(height: 10),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget folderCard(String tab) {
    final langs = profile![tab] as Map<String, dynamic>;
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: langs.entries.map((e) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text("${e.key}: ${e.value}"),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget skillsCard() {
    final skills = profile!["skills"] as Map<String, dynamic>;
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: skills.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text("${entry.key}: ${entry.value.join(', ')}"),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget basicInfoCard() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitle(profile!["name"] ?? ""),
              buildText(profile!["birthday"] ?? ""),
              buildText(profile!["email"] ?? ""),
              buildText(profile!["address"] ?? ""),
            ],
          ),
        ),
      ),
    );
  }

}
