import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medan_hokkien_dictionary/util.dart';

Widget definitionDisplayText(String text, {double normalSize = 16, double tagSizeScale = 0.7}) {
  final words = text.split(' ');

  return RichText(text: TextSpan(
    children: words.map((word) {
      final isTag = word.startsWith('#');

      return TextSpan(
        text: isTag ? '${word.substring(1)} ' : '$word ',
        style: (isTag ? TextStyle(fontFamily: 'ThickFont') : GoogleFonts.roboto()).copyWith(
          fontSize: isTag ? tagSizeScale * normalSize : normalSize,
          fontWeight: isTag ? FontWeight.w900 : FontWeight.w200,
          letterSpacing: isTag ? 1.5 : null,
          color: isTag ? Colors.white : const Color.fromARGB(255, 217, 217, 217)
        ),
      );
    }).toList(),
  ));
}

class EntryPage extends StatelessWidget {
  final EntryData entryData;

  const EntryPage({
    super.key,
    required this.entryData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // TOP THIN DARKER RED LINE
          Container(
            height: 3.5,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red.shade900,
            ),
          ),

          // TOP BAR
          Container(
            height: 60.0,
            width: double.infinity,
            color: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                // BACK BUTTON
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),

                const SizedBox(width: 8),

                Expanded(child: Text(
                  'Entry ${entryData.index}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                )),

                const SizedBox(width: 48),
              ],
            ),
          ),

          // PAGE CONTENT
          Expanded(
            child: Center(
              child: Text(
                'Page content goes here',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}