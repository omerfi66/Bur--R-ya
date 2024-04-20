import 'package:flutter/material.dart';
import 'package:gemini_gdsc/model/apikey.dart';
import 'package:gemini_gdsc/view/dream/tabir_sayfa.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_gemini/google_gemini.dart';

class TextOnly extends StatefulWidget {
  const TextOnly({Key? key}) : super(key: key);

  @override
  State<TextOnly> createState() => _TextOnlyState();
}

class _TextOnlyState extends State<TextOnly> {
  List<Map<String, String>> textChat = [];
  bool loading = false;

  final TextEditingController _textController = TextEditingController();
  final gemini = GoogleGemini(apiKey: GeminiApiKey.apiKey);

  void queryText({required String query}) {
    // Gizli metni ekleyin
    String hiddenMessage = 'Bu bir rüyadır ve bunu yorumla: $query';
    textChat.add({
      "role": "Hidden",
      "text": hiddenMessage,
    });

    setState(() {
      loading = true;
    });

    gemini.generateFromText(hiddenMessage).then((value) {
      setState(() {
        loading = false;
        textChat.add({
          "role": "User",
          "text": query,
        });
        textChat.add({
          "role": "Gemini",
          "text": value.text,
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondPage(aiResponse: value.text),
          ),
        );
      });
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
        textChat.add({
          "role": "User",
          "text": query,
        });
        textChat.add({
          "role": "Gemini",
          "text": error.toString(),
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/dream.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).size.width * 0.15,
            left: MediaQuery.of(context).size.width * 0.03,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 35,
                    )),
              ],
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Rüya Tabiri..',
              style: GoogleFonts.indieFlower(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          cursorColor: Colors.white,
                          controller: _textController,
                          maxLines: 7,
                          decoration: InputDecoration(
                            hintText: "Rüyanızı anlatın..",
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Colors.transparent,
                          ),
                          keyboardType: TextInputType.multiline,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    String query = _textController.text;

                    if (!query.toLowerCase().contains("rüya")) {
                      query =
                          "sana bir ruya tabiri yaptirmak istiyorum.. ne gördüğüüümü sana anlatacağım ve sende  yorumlayacaksın... : rüyamda, ' $query ' gördüm.. bu rüyamı  yorumla tesekkurler";
                    }
                    queryText(query: query);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    minimumSize: const Size(150, 44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: loading
                      ? const CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        )
                      : const Text(
                          'Tabirle',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w900),
                        ),
                )
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
