import 'package:flutter/material.dart';
import 'blog_post_page.dart';
import 'quote_detail_page.dart';
import '../services/content_service.dart';

// Base class for all yap content
abstract class YapContent {
  final String type;
  final String date;

  const YapContent({required this.type, required this.date});
}

// Blog post class
class BlogPost extends YapContent {
  final String title;
  final String preview;
  final String content;

  BlogPost({
    required String date,
    required this.title,
    required this.preview,
    required this.content,
  }) : super(type: 'blog', date: date);
}

// Quote class
class QuotePost extends YapContent {
  final String quote;
  final String? attribution;
  final String? detailedContent;

  QuotePost({
    required String date,
    required this.quote,
    this.attribution,
    this.detailedContent,
  }) : super(type: 'quote', date: date);
}

// Combined list of all yap content
final List<YapContent> yapContent = [
  BlogPost(
    title: 'if this here, directory load incomplete',
    date: 'january 15, 2024',
    preview: 'a step-by-step guide to creating your developer portfolio...',
    content: 'full article content goes here...',
  ),
  QuotePost(
    date: 'january 20, 2024',
    quote: 'closed mouths don\'t get fed',
    detailedContent:
        'This quote emphasizes the importance of speaking up and asking for what you want...',
  ),
  QuotePost(
    date: 'january 15, 2024',
    quote: 'consistency is the key to mastery',
    attribution: 'unknown',
    detailedContent: 'The power of consistency cannot be overstated...',
  ),
  BlogPost(
    title: 'getting started with flutter web',
    date: 'january 1, 2024',
    preview: 'learn how to build your first flutter web application...',
    content: 'full article content goes here...',
  ),
];

// Update the BlogPage widget to handle both types
class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  late Future<List<YapContent>> _contentFuture;

  @override
  void initState() {
    super.initState();
    _contentFuture = ContentService.loadContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('yap'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<YapContent>>(
        future: _contentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final content = snapshot.data!;
          return ListView.builder(
            itemCount: content.length,
            itemBuilder: (context, index) {
              final item = content[index];
              if (item is QuotePost) {
                return _buildQuoteCard(item);
              } else if (item is BlogPost) {
                return _buildBlogCard(item as BlogPost, context);
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }

  Widget _buildQuoteCard(QuotePost quote) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuoteDetailPage(quote: quote),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
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

  Widget _buildBlogCard(BlogPost post, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          post.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(post.date),
            const SizedBox(height: 8),
            Text(post.preview),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlogPostPage(post: post),
            ),
          );
        },
      ),
    );
  }
}
