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
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white, foregroundColor: Colors.black)),
      home: const RandomWords(),
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
  final _saved = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(' Start up name Generator'), actions: [
        IconButton(
          onPressed: _pushSaved,
          icon: const Icon(Icons.list),
          tooltip: 'Saved suggestion',
        )
      ]),
      body: ListView.builder(itemBuilder: (context, index) {
        final i = index ~/ 2;

        if (index.isOdd) {
          return const Divider();
        }

        if (i >= _suggestion.length) {
          _suggestion.addAll(generateWordPairs().take(10));
        }

        final alreadySaved = _saved.contains(_suggestion[i]);

        return ListTile(
          title: Text(
            _suggestion[i].asPascalCase,
            style: _biggerFont,
          ),
          trailing: Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,
            semanticLabel: alreadySaved ? 'Removed from savd' : 'Save',
          ),
          onTap: () {
            setState(() {
              if (alreadySaved) {
                _saved.remove(_suggestion[i]);
              } else {
                _saved.add(_suggestion[i]);
              }
            });
          },
        );
      }),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final tile = _saved.map((item) {
        return ListTile(
          title: Text(item.asPascalCase, style: _biggerFont),
        );
      });
      final divided = tile.isNotEmpty
          ? ListTile.divideTiles(tiles: tile, context: context).toList()
          : <Widget>[];

      return Scaffold(
        appBar: AppBar(
          title: const Text('Saved favourites'),
        ),
        body: ListView(children: divided),
      );
    }));
  }
}
