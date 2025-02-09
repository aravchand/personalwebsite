import 'package:flutter/material.dart';
import 'projects_page.dart';

class ProjectDetailPage extends StatelessWidget {
  final Project project;

  const ProjectDetailPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.title,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: project.technologies
                    .map((tech) => Chip(label: Text(tech)))
                    .toList(),
              ),
              const SizedBox(height: 24),
              Text(
                project.detailedDescription,
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (project.demoUrl != null)
                    ElevatedButton.icon(
                      onPressed: () {
                        // Add URL launcher functionality
                      },
                      icon: const Icon(Icons.launch),
                      label: const Text('live demo'),
                    ),
                  if (project.githubUrl != null)
                    ElevatedButton.icon(
                      onPressed: () {
                        // Add URL launcher functionality
                      },
                      icon: const Icon(Icons.code),
                      label: const Text('view code'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}