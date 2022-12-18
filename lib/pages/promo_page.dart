import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PromoPage extends StatefulWidget {
  const PromoPage({super.key});

  @override
  State<PromoPage> createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage> {
  TextEditingController promoTitle = TextEditingController();
  TextEditingController promoCode = TextEditingController();
  TextEditingController promoAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white54,
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width - 300,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Promotion Creation",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Promo Title",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                      width: 200,
                      child: TextField(
                        decoration:
                            const InputDecoration(hintText: "Year End Sale"),
                        controller: promoTitle,
                      )),
                  const Text(
                    "Promo Code",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                      width: 200,
                      child: TextField(
                        decoration: const InputDecoration(hintText: "#123456"),
                        controller: promoCode,
                      )),
                  const Text(
                    "Promo Amount",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                      width: 200,
                      child: TextField(
                        decoration: const InputDecoration(hintText: "RM0.00"),
                        controller: promoAmount,
                      )),
                  InkWell(
                    onTap: () {
                      FirebaseFirestore.instance.collection("Promotion").add({
                        "promotion_code": promoCode.text,
                        "promotion_title": promoTitle.text,
                        "promo_amount": promoAmount.text,
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Created Promotion",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Promotion")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 100,
                              color: Colors.deepOrangeAccent,
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                children: [
                                  Container(
                                    height: 100,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      "RM ${snapshot.data!.docs[index]['promo_amount']}",
                                      style: const TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        snapshot.data!.docs[index]
                                            ['promotion_title'],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "#${snapshot.data!.docs[index]['promotion_code']}",
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          });
                    }
                    return const SizedBox();
                  }),
              Container(
                color: Colors.white54,
                padding: const EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width - 300,
              ),
            ],
          ),
        ));
    ;
  }
}
