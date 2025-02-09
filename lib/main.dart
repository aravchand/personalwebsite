import 'package:flutter/material.dart';
import 'pages/blog_page.dart';
import 'pages/blog_post_page.dart';
import 'pages/projects_page.dart';
import 'pages/project_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pages/quote_detail_page.dart';

void main() {
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();

  // Update the keys map to match the lowercase section labels
  final Map<String, GlobalKey> _keys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'projects': GlobalKey(),
    'yap': GlobalKey(),
    'contact': GlobalKey(),
  };

  void _scrollToSection(String label) {
    // Use the lowercase label directly
    final key = _keys[label.toLowerCase()];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('arav chand'),
        actions: [
          for (var label in ['home', 'about', 'projects', 'yap', 'contact'])
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                onPressed: () => _scrollToSection(label),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Color.fromARGB(155, 0, 51, 14),
                    fontSize: 18,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Hero Section
            Container(
              key: _keys['home'],
              height: 500,
              color: Colors.blue.shade50,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(Icons.person,
                          size: 80, color: Colors.blue.shade700),
                      // backgroundImage: AssetImage('assets/profile.jpg'), // Comment this out for now
                    ),
                    SizedBox(height: 20),
                    Text(
                      'arav chand',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'software developer | flutter expert | web developer',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // About Section
            Container(
              key: _keys['about'],
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    const Text(
                      'about me',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Write your bio here. Tell visitors about yourself, your skills, '
                      'and what makes you unique. This is your chance to make a great first impression.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // Projects Section
            Container(
              key: _keys['projects'],
              color: Colors.grey[100],
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'projects / stuff i work(ed) on',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProjectsPage()),
                          );
                        },
                        icon: const Icon(Icons.code),
                        label: const Text('view all projects'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: [
                          for (var project in projects.take(2))
                            _buildProjectCard(
                              project.title,
                              project.description,
                              constraints.maxWidth > 1200
                                  ? (constraints.maxWidth - 60) / 2
                                  : constraints.maxWidth - 40,
                              project,
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            // Blog Section
            Container(
              key: _keys['yap'],
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'latest yap',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BlogPage()),
                          );
                        },
                        icon: const Icon(Icons.article),
                        label: const Text('view all yap'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: [
                          for (var content in yapContent.take(2))
                            if (content is BlogPost)
                              _buildBlogCard(
                                content.title,
                                content.date,
                                content.preview,
                                constraints.maxWidth > 1200
                                    ? (constraints.maxWidth - 60) / 2
                                    : constraints.maxWidth - 40,
                                content,
                              )
                            else if (content is QuotePost)
                              _buildQuotePreviewCard(
                                content,
                                constraints.maxWidth > 1200
                                    ? (constraints.maxWidth - 60) / 2
                                    : constraints.maxWidth - 40,
                              ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            // Contact Section
            Container(
              key: _keys['contact'],
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    const Text(
                      'contact me',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.email),
                            const SizedBox(width: 8),
                            TextButton(
                              onPressed: () => launchUrl(
                                  Uri.parse('mailto:aravchando8@gmail.com')),
                              child: const Text('aravchando8@gmail.com'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.link),
                            const SizedBox(width: 8),
                            TextButton(
                              onPressed: () => launchUrl(Uri.parse(
                                  'https://www.linkedin.com/in/arav-chand-978120211/')),
                              child:
                                  const Text('linkedin @arav-chand-978120211'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.code),
                            const SizedBox(width: 8),
                            TextButton(
                              onPressed: () => launchUrl(
                                  Uri.parse('https://github.com/aravchand')),
                              child: const Text('github @aravchand'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(
      String title, String description, double width, Project project) {
    return Card(
      elevation: 4,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjectDetailPage(project: project),
                  ),
                );
              },
              child: const Text('learn more'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlogCard(
      String title, String date, String preview, double width, BlogPost post) {
    return Card(
      elevation: 4,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.article, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              preview,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogPostPage(post: post),
                  ),
                );
              },
              icon: const Icon(Icons.read_more),
              label: const Text('read more'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuotePreviewCard(QuotePost quote, double width) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuoteDetailPage(quote: quote),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Container(
          width: width,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.format_quote, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    quote.date,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                quote.quote,
                style: const TextStyle(
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                ),
              ),
              if (quote.attribution != null) ...[
                const SizedBox(height: 8),
                Text(
                  '- ${quote.attribution}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
