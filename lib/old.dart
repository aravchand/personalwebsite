import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: PortfolioTabs(),
    );
  }
}

class PortfolioTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Portfolio'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'About Me'),
              Tab(text: 'Projects'),
              Tab(text: 'Resume & CV'),
              Tab(text: 'Blog'),
              Tab(text: 'Contact'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HeaderSection(),
            AboutMeSection(),
            ProjectsSection(),
            ResumeSection(),
            BlogSection(),
            ContactSection(),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome to My Portfolio', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text('Aspiring Mathematician | CS Enthusiast'),
        ],
      ),
    );
  }
}

class AboutMeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Text('I am a passionate student pursuing Mathematics and Computer Science at Georgia Tech.'),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('- Project 1: Mathematical Model Exploration'),
          Text('- Project 2: AI Quantitative Finance Analysis'),
        ],
      ),
    );
  }
}

class ResumeSection extends StatelessWidget {
  final String resumeUrl = 'https://your_resume_link.com';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          if (await canLaunch(resumeUrl)) {
            await launch(resumeUrl);
          }
        },
        child: Text('Download Resume'),
      ),
    );
  }
}

class BlogSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('- Blog Post 1: Exploring Advanced Calculus'),
          Text('- Blog Post 2: Machine Learning in Finance'),
        ],
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  final String email = 'mailto:your_email@example.com';
  final String linkedIn = 'https://www.linkedin.com/in/arav-chand-978120211/';
  final String github = 'https://github.com/yourgithub';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(onPressed: () async { if (await canLaunch(email)) await launch(email); }, child: Text('Email Me')),
          TextButton(onPressed: () async { if (await canLaunch(linkedIn)) await launch(linkedIn); }, child: Text('LinkedIn')),
          TextButton(onPressed: () async { if (await canLaunch(github)) await launch(github); }, child: Text('GitHub')),
        ],
      ),
    );
  }
}