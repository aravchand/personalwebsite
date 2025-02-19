// "assetmanifest.json" is no longer supported (phased out)
import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../pages/blog_page.dart';

class ContentService {
  static Future<List<YapContent>> loadContent() async {
    final List<YapContent> content = [];

    // Load quotes
    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      print('Manifest loaded: $manifestContent');

      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      print('Manifest map: $manifestMap'); // Debug print
      print('Manifest keys: ${manifestMap.keys}'); // Debug print

      final quotePaths = manifestMap.keys
          .where((String key) => key.startsWith('assets/content/quotes/'));
      final blogPaths = manifestMap.keys
          .where((String key) => key.startsWith('assets/content/blogs/'));

      print('Quote paths: $quotePaths');
      print('Blog paths: $blogPaths');

      // Load quotes
      for (var path in quotePaths) {
        try {
          final String fileContent = await rootBundle.loadString(path);
          final parsedContent = parseMarkdownContent(fileContent);

          if (parsedContent['type'] == 'quote') {
            content.add(QuotePost(
              date: parsedContent['date'],
              quote: parsedContent['quote'],
              attribution: parsedContent['attribution'],
              detailedContent: parsedContent['content'],
            ));
          }
        } catch (e) {
          print('Failed to load quote file: $path, $e');
        }
      }

      // Load blogs
      for (var path in blogPaths) {
        try {
          final String fileContent = await rootBundle.loadString(path);
          final parsedContent = parseMarkdownContent(fileContent);

          if (parsedContent['type'] == 'blog') {
            content.add(BlogPost(
              date: parsedContent['date'],
              title: parsedContent['title'],
              preview: parsedContent['preview'],
              content: parsedContent['content'],
            ));
          }
        } catch (e) {
          print('Failed to load blog file: $path, $e');
        }
      }
    } catch (e) {
      print('Error loading content: $e');
    }

    // Sort by date (newest first)
    content.sort((a, b) => b.date.compareTo(a.date));
    return content;
  }

  static Map<String, dynamic> parseMarkdownContent(String content) {
    final RegExp frontMatterRegExp =
        RegExp(r'^---\n(.*?)\n---\n(.*)', dotAll: true);
    final match = frontMatterRegExp.firstMatch(content);

    if (match != null) {
      final frontMatter = loadYaml(match.group(1)!) as Map;
      final markdownContent = match.group(2)!.trim();

      return {
        ...frontMatter,
        'content': markdownContent,
      };
    }

    throw Exception('Invalid markdown format');
  }
}
