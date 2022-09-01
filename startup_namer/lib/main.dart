import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

// Stateless widget are immutable: MEANING THIER PROPERTIES CANNOT CHANGE
// THEY ARE FINAL
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Start up Name Generator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Start up Name Generator'),
        ),
        body: const Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}

// STATEFUL WIDGET: 1. StateFulWidget and 2. State Class
class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() {
    return _RandomWordsState();
  }
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestion = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      final i = index ~/ 2;

      if (index.isOdd) {
        return const Divider();
      }

      if (i >= _suggestion.length) {
        _suggestion.addAll(generateWordPairs().take(10));
      }

      return ListTile(
        title: Text(
          _suggestion[i].asPascalCase,
          style: _biggerFont,
        ),
      );
    });
  }
}
