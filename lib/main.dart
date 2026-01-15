import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medan_hokkien_dictionary/dictionary.dart';
import 'package:medan_hokkien_dictionary/page.dart';
import 'package:medan_hokkien_dictionary/style.dart';
import 'package:medan_hokkien_dictionary/util.dart';

List<Entry> kEntries = List.empty(growable: true);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medan Hokkien Dictionary',
      theme: kAppTheme,
      home: const LoadingPage(title: 'Loading Page'),
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key, required this.title});

  final String title;

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  double progress = 0.0;

  void getAllEntries() async {
    String dictionaryText = await loadDictionary();
    final dictionarySections = dictionaryText.split("\n");
    final sections = dictionarySections.length;

    StringBuffer buffer = StringBuffer();

    var index = 0;
    while (index < sections) {
      final section = dictionarySections[index];
      if (section.isNotEmpty && charAtUni(section, 0) == '=') {
        kEntries.add(parseEntry(buffer.toString().trimRight()));

        setState(() {
          progress += 1.0 / 1689.0;
        });
        
        buffer.clear();
      }

      buffer.write(section);
      buffer.write("\n");
      
      index++;
    }
    
    final bufferString = buffer.toString().trimRight();
    if (bufferString.isNotEmpty) {
      kEntries.add(parseEntry(bufferString));
    }

    await Future.delayed(const Duration(milliseconds: 750));

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const DictionaryPage(title: 'Dictionary Page')),
    );
  }

  @override
  void initState() {
    super.initState();
    
    getAllEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 0.6 * MediaQuery.of(context).size.width, child:
              LinearProgressIndicator(
                value: progress,
                minHeight: 50.0,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.red,
                backgroundColor: const Color.fromARGB(255, 76, 18, 14),
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Loading Dictionary: ${(progress * 100).toStringAsFixed(1)}%',
              style: kUITextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
            ),
          ],
        ),
      )
    );
  }
}
