
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medan_hokkien_dictionary/main.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key, required this.title});

  final String title;

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  bool isEnglish = true;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 3.5,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red.shade900
            ),
          ),

          // TOP BAR
          Container(
            height: 60.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  // SEARCH BAR
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: TopSearchBanner(isEnglish: isEnglish, searchController: searchController)
                  ),
                  Padding(padding: EdgeInsetsGeometry.all(10)),
                  // CHINESE/ENGLISH TOGGLE BUTTON
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: ToggleLangIcon(
                      isEnglish: isEnglish,
                      onToggle: () {
                        setState(() {
                          isEnglish = !isEnglish;
                        });
                      },
                    )
                  )
                ])
              ],
            )
          ),
          Expanded(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Text('Welcome to the Medan Hokkien dictionary.\nCurrently, there are ${kEntries.length} entries.\n\nTap the icon on the top right to toggle between English and Chinese/POJ search.',
                  style: GoogleFonts.notoSans().copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}

class TopSearchBanner extends StatelessWidget {
  final TextEditingController searchController;
  final bool isEnglish;
  
  const TopSearchBanner({
    super.key,
    required this.isEnglish,
    required this.searchController
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IgnorePointer(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
          ),
        ),

        Material(
          color: Colors.transparent,
          elevation: 0,
          borderRadius: BorderRadius.circular(16),
          child: TextField(
            key: ValueKey(isEnglish),
            controller: searchController,
            style: TextStyle(
              color: Colors.white,
              fontFamily: GoogleFonts.notoSans().fontFamily!,
              fontWeight: FontWeight.bold
            ),
            onChanged: (value) {
              print("User typed: $value");
            },
            decoration: InputDecoration(
              hintText: isEnglish ? "Search in English..." : "Search in Chinese or POJ...",
              hintStyle: const TextStyle(
                color: Colors.white,
              ),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.cyan),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ToggleLangIcon extends StatelessWidget {
  final bool isEnglish;
  final VoidCallback onToggle;

  const ToggleLangIcon({
    super.key,
    required this.isEnglish,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onToggle,
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child: Text(
            isEnglish ? 'E' : 'C',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      )
    );
  }
}