import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  TextEditingController categoryIdController = TextEditingController();
  TextEditingController typeController = TextEditingController();

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
                "New Category",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Category ID",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                      width: 200,
                      child: TextField(
                        decoration: const InputDecoration(hintText: "Burger"),
                        controller: categoryIdController,
                      )),
                  const Text(
                    "Category Type",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                      width: 200,
                      child: TextField(
                        decoration:
                            const InputDecoration(hintText: "Beef Burger"),
                        controller: typeController,
                      )),
                  InkWell(
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection("Customization")
                          .add({
                        "category_id": categoryIdController.text,
                        "type": typeController.text,
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
                      .collection("Customization")
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
                              color: const Color.fromARGB(255, 255, 210, 64),
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                children: [
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
                                            ['category_id'],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "Type: ${snapshot.data!.docs[index]['type']}",
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
