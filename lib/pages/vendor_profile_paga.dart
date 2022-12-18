import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:foodie_admin_panel/components/button_component.dart';
import 'package:foodie_admin_panel/components/input_component.dart';
import 'package:foodie_admin_panel/components/menu_component.dart';
import 'package:image_picker/image_picker.dart';

class VendorProfilePage extends StatefulWidget {
  final String restaurant, mall, location, email, unitNo;
  const VendorProfilePage(
      {super.key,
      required this.restaurant,
      required this.mall,
      required this.location,
      required this.email,
      required this.unitNo});

  @override
  State<VendorProfilePage> createState() => _VendorProfilePageState();
}

class _VendorProfilePageState extends State<VendorProfilePage> {
  TextEditingController foodNameController = TextEditingController();
  TextEditingController foodPriceController = TextEditingController();
  TextEditingController foodCategoryController = TextEditingController();
  TextEditingController foodCodeController = TextEditingController();
  TextEditingController foodDescriptionController = TextEditingController();

  CollectionReference menuRef = FirebaseFirestore.instance.collection("Menu");
  ImagePicker imagePicker = ImagePicker();
  XFile? file;
  String imageUrl = "";
  bool isLoading = false;
  bool canUpload = false;
  void pickImage() async {
    isLoading = true;
    file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
    // upload to firebase storage
    // get a reference to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('image');

    //create a reference for the image to be stored
    Reference referenceImageToUpload = referenceDirImages.child(uniqueName);

    //handle errors
    try {
      //Store the file
      await referenceImageToUpload.putFile(File(file!.path));

      imageUrl = await referenceImageToUpload.getDownloadURL();
      if (imageUrl != null) {
        setState(() {
          isLoading = false;
          canUpload = true;
        });
      }
      print(imageUrl);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 80,
                padding: const EdgeInsets.all(8),
                color: Colors.blue,
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width,
                child: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.lightBlue),
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/vendor.png",
                    width: 100.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  widget.restaurant,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 32),
                ),
                const SizedBox(
                  width: 50,
                ),
                ButtonComponent(
                  label: "Add Menu",
                  color: Colors.amber,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 400,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Add Menu",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      InputComponent(
                                        controller: foodNameController,
                                        hintText: "Food name",
                                      ),
                                      InputComponent(
                                        controller: foodDescriptionController,
                                        hintText: "Food description",
                                      ),
                                      InputComponent(
                                        controller: foodCategoryController,
                                        hintText: "Food category",
                                      ),
                                      InputComponent(
                                        controller: foodCodeController,
                                        hintText: "Food code",
                                      ),
                                      InputComponent(
                                        controller: foodPriceController,
                                        hintText: "Food price",
                                      ),
                                      isLoading == false
                                          ? ButtonComponent(
                                              color: Colors.green,
                                              buttonWidth: 200,
                                              label: "Upload an image",
                                              onTap: pickImage,
                                            )
                                          : Text(imageUrl),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      ButtonComponent(
                                        label: "Save",
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection("Restaurants")
                                              .add({
                                            "code": "1",
                                            "food_name":
                                                foodNameController.text,
                                            "food_category":
                                                foodCategoryController.text,
                                            "food_code":
                                                foodCodeController.text,
                                            "food_description":
                                                foodDescriptionController.text,
                                            "price": foodPriceController.text,
                                            "location": widget.location,
                                            "image":
                                                "https://i.picsum.photos/id/42/3456/2304.jpg?hmac=dhQvd1Qp19zg26MEwYMnfz34eLnGv8meGk_lFNAJR3g",
                                            "email": widget.email,
                                            "mall": widget.mall,
                                          }).then((value) {
                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                    ],
                                  )),
                            ));
                  },
                )
              ],
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Menu",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Restaurants")
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
                          if (snapshot.data!.docs[index]['email'] ==
                              widget.email) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: MenuComponent(
                                deleteFunc: () {
                                  snapshot.data!.docs[index].reference
                                      .delete()
                                      .whenComplete(
                                        () => Navigator.pop(context),
                                      );
                                },
                                editFunc: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                            child: Container(
                                              width: 500,
                                              height: 400,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8),
                                              child: Column(children: [
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                const Text(
                                                  "Edit Menu",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                TextField(
                                                  controller:
                                                      foodNameController,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "Food Name "),
                                                ),
                                                TextField(
                                                  controller:
                                                      foodPriceController,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText: "RM 0.00"),
                                                ),
                                                TextField(
                                                  controller:
                                                      foodCategoryController,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText: "Category"),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                ButtonComponent(
                                                  label: "Update",
                                                  onTap: () {
                                                    if (foodCategoryController.text.isEmpty ||
                                                        foodCategoryController
                                                            .text.isEmpty ||
                                                        foodCategoryController
                                                            .text.isEmpty) {
                                                      showDialog(
                                                          context: context,
                                                          builder:
                                                              (context) =>
                                                                  Dialog(
                                                                    child:
                                                                        Container(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              16,
                                                                          vertical:
                                                                              8),
                                                                      height:
                                                                          50,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      color: Colors
                                                                          .red,
                                                                      child:
                                                                          const Text(
                                                                        "All field must be filled",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color: Colors.white),
                                                                      ),
                                                                    ),
                                                                  ));
                                                    } else {
                                                      snapshot.data!.docs[index]
                                                          .reference
                                                          .update({
                                                        "food_name":
                                                            foodNameController
                                                                .text,
                                                        "food_category":
                                                            foodCategoryController
                                                                .text,
                                                        "price": double.parse(
                                                                foodPriceController
                                                                    .text)
                                                            .toStringAsFixed(2),
                                                      }).then((value) =>
                                                              Navigator.pop(
                                                                  context));
                                                    }
                                                  },
                                                )
                                              ]),
                                            ),
                                          ));
                                },
                                image: snapshot.data!.docs[index]['image'],
                                foodName: snapshot.data!.docs[index]
                                    ['food_name'],
                                foodPrice:
                                    "RM ${snapshot.data!.docs[index]['price']}",
                              ),
                            );
                          }
                          return const SizedBox();
                        });
                  }
                  return const Text("No data available at the moment");
                })
          ],
        ),
      ),
    );
  }
}
