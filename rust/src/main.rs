use std::collections::HashSet;
use std::{fs, io};
use std::process::{Command, ExitStatus};

fn is_cjk_unified(c: char) -> bool {
    let u = c as u32;

    matches!(u,
        0x3400..=0x4DBF |     // Extension A
        0x4E00..=0x9FFF |     // CJK Unified Ideographs
        0xF900..=0xFAFF |     // Compatibility Ideographs
        0x20000..=0x2A6DF |   // Extension B
        0x2A700..=0x2B73F |   // Extension C
        0x2B740..=0x2B81F |   // Extension D
        0x2B820..=0x2CEAF |   // Extension E
        0x2CEB0..=0x2EBEF |   // Extension F
        0x2EBF0..=0x2EE5F |   // Extension G
        0x30000..=0x3134F |   // Extension H
        0x31350..=0x323AF |   // Extension I
        0x323B0..=0x3347F |   // Extension J
        0x2F800..=0x2FA1F     // Compatibility Supplement
    )
}

fn unique_chars(input: &str) -> String {
    let mut chars = HashSet::new();
    let mut result = String::new();

    for c in input.chars() {
        if is_cjk_unified(c) && chars.insert(c) {
            result.push(c);
        }
    }

    result
}

fn main() -> io::Result<()> {
    let input_fonts = ["fonts/font1.ttf", "fonts/font2.ttf", "fonts/font3.ttf", "fonts/font4.ttf"];
    let output_fonts = ["fonts/th-tshyn-1.ttf", "fonts/th-tshyn-2.ttf", "fonts/th-tshyn-3.ttf", "fonts/th-tshyn-4.ttf"];

    let input = fs::read_to_string("../assets/entries/dictionary.txt")?;
    let result = unique_chars(input.as_str());

    fs::write("chars.txt", &result).expect("Cannot write to buffer file.");

    for idx in 0..4 {
        let status = Command::new("python")
            .args([
                "-m",
                "fontTools.subset",
                input_fonts[idx],
                "--text-file=chars.txt",
                "--ignore-missing-glyphs",
                "--ignore-missing-unicodes",

                "--notdef-glyph",
                "--glyphs=+/.null",
                "--glyphs=+/.notdef",

                "--layout-features=*",
                "--glyph-names",
                "--drop-tables+=feat,morx",
                output_fonts[idx],
            ])
            .status()?;
    }

    println!("Font generated with {} glyphs!", result.chars().count());
    Ok(())
}