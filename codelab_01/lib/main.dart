import 'package:flutter/material.dart';
// Copyright (c) 2017, filiph. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final suggestions = <WordPair>[];
    final _saved = <WordPair>{};
    void _pushSaved() {
      Navigator.of(context).push(
        // Add lines from here...
        MaterialPageRoute<void>(
          builder: (context) {
            final tiles = _saved.map(
              (pair) {
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                  ),
                );
              },
            );
            final divided = tiles.isNotEmpty
                ? ListTile.divideTiles(
                    context: context,
                    tiles: tiles,
                  ).toList()
                : <Widget>[];

            return Scaffold(
              appBar: AppBar(
                title: const Text('Saved Suggestions'),
              ),
              body: ListView(children: divided),
            );
          },
        ), // ...to here.
      );
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("WordPairs"),
          actions: [
            IconButton(onPressed: _pushSaved, icon: const Icon(Icons.list))
          ],
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (BuildContext context, int index) {
            if (index.isOdd) {
              return const Divider();
            }
            final i = index ~/ 2;
            suggestions.addAll(generateWordPairs().take(10));
            // final alreadySaved = _saved.contains();
            final alreadySaved = _saved.contains(suggestions[index]);

            return ListTile(
              title: Text(suggestions[index].asPascalCase),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    if (alreadySaved) {
                      _saved.remove(suggestions[index]);
                    } else {
                      _saved.add(suggestions[index]);
                    }
                  });
                },
                icon: Icon(
                  alreadySaved ? Icons.favorite : Icons.favorite_border,
                ),
                color: alreadySaved ? Colors.red : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
