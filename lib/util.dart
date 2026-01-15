String charAtUni(String text, int index) {
  return String.fromCharCode(text.runes.elementAt(index));
}

String charAtUniRunes(Runes runes, int index) {
  return String.fromCharCode(runes.elementAt(index));
}