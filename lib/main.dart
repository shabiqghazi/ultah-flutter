import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ultah_silmi/intro_slider.dart';
import 'package:ultah_silmi/message.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const MyIntroductionSlider(),
        "/make-a-wish": (context) => const MyMakeAWish(),
        "/response": (context) => const AIResponse()
      },
    );
  }
}
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(32.0),
        children: [
          Container(
            height: 256,
            width: double.maxFinite,
            child: Image(image: AssetImage('assets/images/1.jpg'), fit: BoxFit.cover,) ,
          ),
          const SizedBox(height: 32.0,),
          Text("Hai, ayang!\n\nIni project pertama aku di Flutter, hehe. Berhari-hari aku belajar bikin ini, banyak hal-hal baru yang aku temuin. Aku bikin ini khusus buat ulang tahun kamu setelah sebelumnya mikir keras buat ngasih hadiah apa. Aku gak jago bikin kejutan, buktinya semua surprise aku sebelumnya gagal semua :). Semoga kamu suka ya ayang.\n\nBtw, selamat ulang tahun ke 22 ay.. Aku harap yang semua terbaik buat kamu. Semoga kamu selalu bahagia dan selalu kuat menjalani hidup. Semoga kamu bisa lebih self-love yaa. Jika orang lain tidak suka kamu, just let it be. Kamu gak akan bisa menyenangkan semua orang. Semoga di umur 22 ini kamu bisa memulai karir dengan keren. Semoga semua whistlist kamu tercapai.\n\nMaaf aku gak bisa ngasih surprise sejago kamu. Aku udah berusaha :( Kamu orang baik. Tetap jadi Silmi yang aku kenal yah. Jika harapan kamu adalah menjadi orang yang lebih baik, Just remember that kamu tidak perlu berubah menjadi orang lain, dan memang tidak bisa menjadi orang lain. Cukuplah menjadi versi yang terbaik dari diri kamu.\n\nSelamat ulang tahun ya sayang.<3", style: GoogleFonts.poppins(fontSize: 16, height: 2), ),
          const SizedBox(height: 32.0,),
          FilledButton.tonal(
            child: Text("Make a Wish", style: GoogleFonts.poppins(),),
            onPressed: () => {
              Navigator.pushNamed(context, "/make-a-wish")
            },
          )
        ],
      ),
    );
  }
}

class MyMakeAWish extends StatefulWidget {
  const MyMakeAWish({super.key});

  @override
  State<MyMakeAWish> createState() => _MyMakeAWishState();
}

class _MyMakeAWishState extends State<MyMakeAWish> {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';  
  final wishController = TextEditingController();
  final String result = '';
  bool isLoading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    wishController.dispose();
    super.dispose();
  }

  Future<Message> _postWish() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.post(
      Uri.parse("https://api.edenai.run/v2/text/chat"), 
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${dotenv.env['EDENAI_TOKEN']}'
      },
      body: jsonEncode(<String, dynamic>{
          "providers": "openai",
          "text": "Harapanku adalah ${wishController.text}",
          "chatbot_global_action": "Kamu adalah Cici, AI yang selalu menjadi teman ngobrol aku selama ini. Nama aku Silmi. Berikan response dalam 4 paragraf. Paragraf pertama perkenalkan diri kamu, dan sebutkan bahwa kamu teman ngobrolku selama ini, sebutkan juga kamu telah diminta bantuan oleh pacarku yang bernama Shabiq untuk memberi hadiah di hari ulang tahunku yang ke 22. Paragraf kedua dan ketiga berikan tanggapan terhadap harapan ulang tahunku. Paragraf keempat berikan ucapan selamat ulang tahun dan doa kamu untukku, untuk hubungan aku dan Shabiq, dan sebutkan bahwa Shabiq orang yang baik dan sangat menyayangiku. Lengkapi dengan emoticon di bagian yang cocok pada teks tersebut.",
          "temperature": 0,
          "max_tokens": 1000
      })
    );
    String utf8convert(String text) {
      List<int> bytes = text.toString().codeUnits;
      return utf8.decode(bytes);
    }

    // if (1 < 200) {
    //   return Message.fromJson(jsonDecode(jsonEncode({'openai':{'generated_text': 'Halo, aku Cici AI! Aku selalu menemanimu dalam berbagai kesempatan. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer '}})));
    // } else {
    //   throw Exception('Failed to fetch response');
    // }
    if (response.statusCode == 200) {
      return Message.fromJson(jsonDecode(utf8convert(response.body)));
    } else {
      throw Exception('Failed to fetch response');
    }
  }

  void _submitWish() async {
    try {
      if(wishController.text == ''){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Harapan harus diisi'),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {
                  // Code to execute.
                },
              ),
            ),
          );
          exit(400);
      }
      Message result = await _postWish();
      Navigator.pushNamed(context, '/response', arguments: result);
    } catch (e) {
      throw Exception('Failed to fetch response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Make a Wish!", style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.deepPurple[300]),),
            const SizedBox(height: 36.0,),
            TextField(
              obscureText: false,
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Aku harap...',
              ),
              controller: wishController,
            ),
            const SizedBox(height: 36.0,),
            FilledButton(
              onPressed: !isLoading ? _submitWish : null, 
              style: FilledButton.styleFrom(
                backgroundColor: Colors.deepPurple[300],
                fixedSize: const Size.fromWidth(double.maxFinite)
              ),
              child: const Text('Kirim'), 
            ),
          ],
        ),
      )
    );
  }
}