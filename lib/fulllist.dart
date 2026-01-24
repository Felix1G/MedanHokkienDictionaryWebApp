
import 'package:flutter/material.dart';
import 'package:medan_hokkien_dictionary/entry.dart';
import 'package:medan_hokkien_dictionary/main.dart';
import 'package:medan_hokkien_dictionary/style.dart';
import 'package:medan_hokkien_dictionary/util.dart';

double _lastScrollOffset = 0.0;

class FullListPage extends StatefulWidget {
  const FullListPage({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<FullListPage> createState() => _FullListPageState();
}

class _FullListPageState extends State<FullListPage> {
  final ScrollController _scrollController = ScrollController(initialScrollOffset: _lastScrollOffset);

  @override
  void initState() {
    super.initState();
    // Restore offset if it was saved
    _scrollController.addListener(() {
      _lastScrollOffset = _scrollController.offset;
    });
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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

                // ENTRY NUMBER
                Expanded(child: Text(
                  'Entries List',
                  style: kUITextStyle.copyWith(
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
          
          // LIST OF ENTRIES
          Expanded(child: ListView.builder(
            controller: _scrollController,
            physics: ClampingScrollPhysics(),
            itemCount: kEntries.length,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: true,
            itemBuilder: (context, index) {
              final entryData = EntryData(index: index);
              return RepaintBoundary(child: Row(
                children: [
                  SizedBox(
                    width: 70.0,
                    child: Text(
                      "#$index",
                      style: kUITextStyle,
                      textAlign: TextAlign.center
                    )
                  ),

                  const SizedBox(width: 10.0),

                  Expanded(child: respondingCondenseEntryWidget(context, entryData))
                ]
              ));
            },
          ))
        ])
    );
  }
}