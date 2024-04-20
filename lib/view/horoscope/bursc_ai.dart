import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

class BurcAi extends StatelessWidget {
  final String aiResponse;
  final String burc;

  const BurcAi({Key? key, required this.aiResponse, required this.burc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/horos.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 5),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.orange,
                              size: 35,
                            )),
                        Text(
                          '$burc Burcu..',
                          style: GoogleFonts.indieFlower(
                              fontSize: 30,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 30),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.deepPurpleAccent.withOpacity(0.25),
                        ),
                        child: SingleChildScrollView(
                          child: MarkdownBody(
                            data: aiResponse,
                            styleSheet: MarkdownStyleSheet(
                              strong: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                  fontSize: 17,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white),
                              p: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: const Size(150, 44),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Geri',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
