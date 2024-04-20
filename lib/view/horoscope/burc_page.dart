import 'package:flutter/material.dart';
import 'package:gemini_gdsc/model/apikey.dart';
import 'package:gemini_gdsc/view/horoscope/bursc_ai.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_gemini/google_gemini.dart';

class BurcPage extends StatefulWidget {
  const BurcPage({Key? key}) : super(key: key);

  @override
  State<BurcPage> createState() => _BurcPageState();
}

class _BurcPageState extends State<BurcPage> {
  // Burçların yüklenme durumunu tutacak bir liste oluşturun
  List<bool> _isLoadingList = List.generate(12, (index) => false);
  final List<Map<String, String>> _burcImages = [
    {'imagePath': 'assets/images/akrep8.png', 'name': 'Akrep'},
    {'imagePath': 'assets/images/aslan5.png', 'name': 'Aslan'},
    {'imagePath': 'assets/images/balik12.png', 'name': 'Balık'},
    {'imagePath': 'assets/images/basak6.png', 'name': 'Başak'},
    {'imagePath': 'assets/images/boga2.png', 'name': 'Boğa'},
    {'imagePath': 'assets/images/ikizler3.png', 'name': 'İkizler'},
    {'imagePath': 'assets/images/koc1.png', 'name': 'Koç'},
    {'imagePath': 'assets/images/kova11.png', 'name': 'Kova'},
    {'imagePath': 'assets/images/oglak10.png', 'name': 'Oğlak'},
    {'imagePath': 'assets/images/terazi7.png', 'name': 'Terazi'},
    {'imagePath': 'assets/images/yay9.png', 'name': 'Yay'},
    {'imagePath': 'assets/images/yengec4.png', 'name': 'Yengeç'},
  ];

  List<Map<String, String>> textChat = []; //stores messages
  bool loading = false; //for circular loader display
  final gemini = GoogleGemini(apiKey: GeminiApiKey.apiKey);

  void queryText({required String query, required int index}) {
    setState(() {
      _isLoadingList = List.generate(12, (index) => false);

      _isLoadingList[index] = true;
    });
    String hiddenMessage =
        'Merhaba senden öncelikle $query burcunun bu günlük burç yorumunu, sonra, $query burcunun genel bir yorumunu ve son olarak önümüzdeki günlerin $query burcuna sahip kişiler için nasıl geçecegini yaz';
    textChat.add({
      "text": hiddenMessage,
    });

    setState(() {
      loading = true;
    });

    gemini.generateFromText(hiddenMessage).then((value) {
      setState(() {
        loading = false;
        _isLoadingList[index] = false;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BurcAi(
                aiResponse: value.text, burc: _burcImages[index]['name']!),
          ),
        );
      });
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
        _isLoadingList[index] = false;
      });
    });
  }

  Widget _buildButton(int index) {
    bool isLoading = _isLoadingList[index];

    return GestureDetector(
      onTap: () {
        String query = _burcImages[index]['name']!;
        queryText(query: query, index: index);
      },
      child: Column(
        children: [
          isLoading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.height * 0.1,
                  child: const CircularProgressIndicator(
                    strokeAlign: CircularProgressIndicator.strokeAlignInside,
                    backgroundColor: Colors.white,
                    color: Colors.orange,
                    strokeWidth: 10,
                  ),
                )
              : Column(
                  children: [
                    Image.asset(
                      _burcImages[index]['imagePath']!,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.width * 0.25, // 3.9,
                      width: double.infinity,
                    ),
                    Text(
                      _burcImages[index]['name']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade400,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

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
                        color: Colors.orange,
                        size: 35,
                      )),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.06),
                  Text(
                    'Günlük Burç Yorumu..',
                    style: GoogleFonts.indieFlower(
                        fontSize: 30,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 28.0,
                  crossAxisSpacing: 8.0,
                ),
                itemCount: _burcImages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildButton(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
