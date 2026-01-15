import 'package:flutter/services.dart' show rootBundle;

class Definition {
  String category;
  String semantics;
  String content;

  Definition({required this.category, required this.semantics, required this.content});
}

class Entry {
  List<String> hanzi;
  List<String> poj;
  List<Definition> definitions;

  Entry({required this.hanzi, required this.poj, required this.definitions});
}

Entry parseEntry(String text) {
  return Entry(hanzi: List.empty(), poj: List.empty(), definitions: List.empty());
}

Future<String> loadDictionary() async {
  return await rootBundle.loadString('entries/dictionary.txt');
}