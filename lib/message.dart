import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Message {
  String content;

  Message.fromJson(Map<String, dynamic> json)
      :
        content = json['openai']['generated_text'];
}

class AIResponse extends StatefulWidget {
  const AIResponse({super.key, this.content = ''});
  final String content;

  @override
  State<AIResponse> createState() => _AIResponseState();
}

class _AIResponseState extends State<AIResponse> {
  String responsePrintState = '';
  int letterCount = 1;
  
  Message args = Message.fromJson(jsonDecode(jsonEncode({'openai':{'generated_text': ''}})));

  @override
  void initState() {
    super.initState(); 

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if(letterCount < args.content.length){
          responsePrintState = args.content.substring(0, letterCount);
          letterCount += 1;
        } else if (letterCount - args.content.length < 5 ) {
          responsePrintState = args.content.substring(0, args.content.length);
          letterCount += 1;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {    
    args = ModalRoute.of(context)!.settings.arguments == null ? Message.fromJson(jsonDecode(jsonEncode({'openai':{'generated_text': ''}}))) : ModalRoute.of(context)!.settings.arguments as Message;

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(32.0),
        children: [
          Column(
            children: [ 
              ClipRRect(
              borderRadius: BorderRadius.circular(9999.0), // Image border
              child: Image.network('https://sf-flow-web-cdn.ciciaicdn.com/obj/ocean-flow-web-us/cici/logo_new.png', fit: BoxFit.cover, height: 128, width: 128,),
            ),
            const SizedBox(height: 24.0,),
            Text(responsePrintState, style: GoogleFonts.poppins(fontSize: 20, height: 2),)
            // TypingText(words: [args.content], letterSpeed: const Duration(microseconds: 100), ),
          ],
          ),
        ],
      ),
    );
  }
}