import 'package:flutter/material.dart';
import 'project_detail_page.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('projects'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  project.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(project.description),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProjectDetailPage(project: project),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class Project {
  final String title;
  final String description;
  final String detailedDescription;
  final String imageUrl;
  final List<String> technologies;
  final String? demoUrl;
  final String? githubUrl;

  const Project({
    required this.title,
    required this.description,
    required this.detailedDescription,
    required this.imageUrl,
    required this.technologies,
    this.demoUrl,
    this.githubUrl,
  });
}

final List<Project> projects = [
  Project(
    title: 'project 1',
    description: 'a cool flutter app',
    detailedDescription: 'detailed description of project 1...',
    imageUrl: 'assets/project1.jpg',
    technologies: ['flutter', 'firebase', 'dart'],
    demoUrl: 'https://demo1.com',
    githubUrl: 'https://github.com/user/project1',
  ),
  Project(
    title: 'project 2',
    description: 'an awesome web app',
    detailedDescription: 'detailed description of project 2...',
    imageUrl: 'assets/project2.jpg',
    technologies: ['react', 'node.js', 'mongodb'],
    demoUrl: 'https://demo2.com',
    githubUrl: 'https://github.com/user/project2',
  ),
  // Add more projects as needed
];
