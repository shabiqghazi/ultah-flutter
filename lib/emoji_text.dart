import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmojiText extends StatelessWidget {
  const EmojiText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: _buildText(text),
    );
  }

  TextSpan _buildText(String text) {
    final children = <TextSpan>[]; 
    final runes = text.runes;

    for (int i = 0; i < runes.length; /* empty */ ) {
      int current = runes.elementAt(i);

      // we assume that everything that is not
      // in Extended-ASCII set is an emoji...
      final isEmoji = current > 255;
      final shouldBreak = isEmoji
        ? (x) => x <= 255 
        : (x) => x > 255;

      final chunk = <int>[];
      while (! shouldBreak(current)) {
        chunk.add(current);
        if (++i >= runes.length) break;
        current = runes.elementAt(i);
      }

      children.add(
        TextSpan(
          text: String.fromCharCodes(chunk),
          style: isEmoji ? const TextStyle(fontFamily: 'EmojiOne', fontSize: 24) : GoogleFonts.poppins(fontSize: 24)
        ),
      );
    }

    return TextSpan(children: children);
  } 
} 