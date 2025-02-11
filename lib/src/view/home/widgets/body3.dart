import 'package:flutter/material.dart';
import 'package:oru_phones/src/api/api.dart';

class Body3 extends StatefulWidget {
  const Body3({super.key});

  @override
  State<Body3> createState() => _Body3State();
}

class _Body3State extends State<Body3> {
  late Future<List<dynamic>> faqData;

  @override
  void initState() {
    super.initState();
    faqData = fetchFaq();
  }

  Future<List<dynamic>> fetchFaq() async {
    try {
      return await Api.getFaq();
    } catch (e) {
      print("Error fetching FAQs: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<List<dynamic>>(
        future: faqData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return const Center(child: Text("No FAQs available."));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 16, bottom: 8),
                  child: Text(
                    "Frequently Asked Questions",
                    style: TextStyle(fontSize: 22, color: Color(0xFF525252)),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var faqItem = snapshot.data![index];
                    return FAQItem(
                      question: faqItem["question"] ?? "No Question Available",
                      answer: faqItem["answer"] ?? "No Answer Available",
                    );
                  },
                ),

                NotificationCard(),
                _footer(context),
              ],
            );
          }
        },
      ),
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({required this.question, required this.answer, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Card(
        color: Colors.white,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(question,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(answer, textAlign: TextAlign.left),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
      decoration: BoxDecoration(
        color: Color(0xFFF6C018),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Get Notified About Our\nLatest Offers and Price Drops",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter your email here",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Send",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _footer(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  return Stack(
    children: [
      Container(
        height: size.height * 0.85,
        child: Stack(
          children: [
            Container(
              height: size.height * 0.55,
              color: Color(0xFF363636),
            ),
            Positioned(
              left: size.width * 0.3,
              top: size.height * 0.04,
              child: Text(
                "Download App",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              left: size.width * 0.3,
              top: size.height * 0.38,
              child: Text(
                "Invite a Friend",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
                left: size.width * 0.08,
                top: size.height * 0.1,
                child: Image.asset("assets/footer/image.png")),
            Positioned(
                right: size.width * 0.08,
                top: size.height * 0.1,
                child: Image.asset("assets/footer/image2.png")),
            Positioned(
                left: size.width * 0.23,
                top: size.height * 0.3,
                child: Image.asset("assets/footer/PlayStore.png")),
            Positioned(
                right: size.width * 0.23,
                top: size.height * 0.30,
                child: Image.asset("assets/footer/iOS.png")),
          ],
        ),
      ),
      Positioned(
        bottom: 0,
        child: Image.asset("assets/footer/foot.png"),
      ),
      Positioned(
        bottom: size.height * 0.09,
        left: size.width * 0.36,
        child: Text(
          "or share via",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      Positioned(
        bottom: size.height * 0.02,
        left: size.width * 0.3,
        child: Image.asset("assets/footer/tele.png"),
      ),
      Positioned(
        bottom: size.height * 0.02,
        left: size.width * 0.75,
        child: Image.asset("assets/footer/what.png"),
      ),
      Positioned(
        bottom: size.height * 0.02,
        left: size.width * 0.525,
        child: Image.asset("assets/footer/x.png"),
      ),
      Positioned(
        bottom: size.height * 0.02,
        left: size.width * 0.1,
        child: Image.asset("assets/footer/insta.png"),
      ),
    ],
  );
}
