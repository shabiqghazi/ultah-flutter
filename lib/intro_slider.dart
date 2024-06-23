import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_slider/introduction_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:ultah_silmi/main.dart';

class MyIntroductionSlider extends StatefulWidget {
  const MyIntroductionSlider({super.key});

  @override
  State<MyIntroductionSlider> createState() => _MyIntroductionSliderState();
}

class _MyIntroductionSliderState extends State<MyIntroductionSlider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionSlider(
        items: [
          IntroductionSliderItem(
            logo: LottieBuilder.asset('assets/lottie/slide-1.json', backgroundLoading: true, renderCache: RenderCache.raster, height: 256,),
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text("Hai Silmi Rahmawati!", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple[300]),),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Ini hari apa? Hari Senin wkwk.\nHari senin mah setiap minggu juga ada ya..",style: GoogleFonts.poppins(fontSize: 16, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500, color: Colors.black54),textAlign: TextAlign.center,),
            ),
            backgroundColor: Colors.white,
          ),
          IntroductionSliderItem(
            logo: LottieBuilder.asset('assets/lottie/slide-2.json', backgroundLoading: true, renderCache: RenderCache.raster, height: 256,),
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: Text("Tapi Senin Ini Beda Dong,\nAda Apa Ya?", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple[300]),textAlign: TextAlign.center,),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("24 Juni,\nKok kayak kenal tanggalnya, gak asing.\nHmm.. aku coba inget-inget dulu",style: GoogleFonts.poppins(fontSize: 16, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500, color: Colors.black54),textAlign: TextAlign.center,),
            ),
            backgroundColor: Colors.white,
          ),
          IntroductionSliderItem(
            logo: LottieBuilder.asset('assets/lottie/slide-3.json', backgroundLoading: true, renderCache: RenderCache.raster, height: 256,),
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: Text("Ah Ya!\nAku Inget Sekarang!", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple[300]),textAlign: TextAlign.center,),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Ini Hari ulang tahun kamu!!!\n",style: GoogleFonts.poppins(fontSize: 16, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500, color: Colors.black54),textAlign: TextAlign.center,),
            ),
            backgroundColor: Colors.white,
          ),
          IntroductionSliderItem(
            logo: LottieBuilder.asset('assets/lottie/2.json', backgroundLoading: true, renderCache: RenderCache.raster, height: 256,),
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: Text("Happy Birthday, Ayang!", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple[300]),),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Wish you all the best",style: GoogleFonts.poppins(fontSize: 16, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500, color: Colors.black54),textAlign: TextAlign.center),
            ),
            backgroundColor: Colors.white,
          ),
        ],
        done: const Done(
          child: Icon(Icons.done),
          home: Home(),
        ),
        next: const Next(child: Icon(Icons.arrow_forward)),
        back: const Back(child: Icon(Icons.arrow_back)),
        dotIndicator: DotIndicator(selectedColor: Colors.deepPurple[300]),
      ),
    );
  }
}