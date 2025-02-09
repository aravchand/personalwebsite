import 'package:flutter/material.dart';
import 'blog_page.dart';

class QuoteDetailPage extends StatelessWidget {
  final QuotePost quote;

  const QuoteDetailPage({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('quote'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Fixed quote section at the top
          Container(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  quote.quote,
                  style: const TextStyle(
                    fontSize: 32,
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (quote.attribution != null) ...[
                  const SizedBox(height: 24),
                  Text(
                    '- ${quote.attribution}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                Text(
                  quote.date,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          // Scrollable detailed content
          if (quote.detailedContent != null) ...[
            const Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  quote.detailedContent!,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.6,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
