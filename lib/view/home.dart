import 'package:flutter/material.dart';
import 'package:gemini_gdsc/view/dream/ruya_gir_page.dart';
import 'package:gemini_gdsc/view/horoscope/burc_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).splashColor,
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/foto.png'), fit: BoxFit.fitHeight),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Yapay Zekâ ile..',
                  style: GoogleFonts.indieFlower(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const TextOnly()));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage('assets/dream.jpg'),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(width: 3.5, color: Colors.purple),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Rüya Tabiri',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BurcPage()));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage('assets/horos.jpg'),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(width: 3.5, color: Colors.orange),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Günlük Burç Yorumu',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]));
  }
}
