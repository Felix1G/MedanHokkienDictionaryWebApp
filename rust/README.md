## Font Generation

A single file containing all the 150000+ CJK glyphs may exceed 90MB of memory. However, as this dictionary has less than 3000 entries, the amount of memory used can be shrunk. This directory uses Rust to create a subset of  fonts to only include Chinese characters in 'assets/entries/dictionary.txt'.

The fonts are in the './fonts' folder which are the TH-Tshyn 5.0.0 fonts which can be found [here](http://cheonhyeong.com/Simplified/download.html).

Both Rust and fonttools from Python have to be downloaded to execute this program. The subset font files are then moved to the assets folder in the main directory.