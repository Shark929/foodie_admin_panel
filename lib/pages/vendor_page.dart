import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_admin_panel/components/button_component.dart';
import 'package:foodie_admin_panel/components/input_component.dart';
import 'package:foodie_admin_panel/components/vendor_component.dart';
import 'package:foodie_admin_panel/pages/vendor_profile_paga.dart';

class VendorPage extends StatefulWidget {
  const VendorPage({super.key});

  @override
  State<VendorPage> createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> {
  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController mallController = TextEditingController();
  TextEditingController unitNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  CollectionReference vendorRefs =
      FirebaseFirestore.instance.collection("Vendor");
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white54,
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width - 300,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Vendors",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 30,
              ),
              StreamBuilder(
                  stream: vendorRefs.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                      );
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VendorProfilePage(
                                    restaurant: snapshot.data!.docs[index]
                                        ['restaurant'],
                                    mall: snapshot.data!.docs[index]['mall'],
                                    location: snapshot.data!.docs[index]
                                        ['location'],
                                    email: snapshot.data!.docs[index]['email'],
                                    unitNo: snapshot.data!.docs[index]
                                        ['unit_no'],
                                  ),
                                ),
                              );
                            },
                            child: VendorComponent(
                              color: snapshot.data!.docs[index]['code'] == "0"
                                  ? const Color.fromARGB(255, 200, 97, 90)
                                  : const Color.fromARGB(255, 24, 148, 80),
                              deleteFunc: () {
                                snapshot.data!.docs[index].reference.delete();
                              },
                              editFunc: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                          child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  400,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  200,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 16),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Edit Vendor Profile",
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  InputComponent(
                                                    controller:
                                                        restaurantNameController,
                                                    hintText:
                                                        "Restaurant: ${snapshot.data!.docs[index]['restaurant']}",
                                                  ),
                                                  InputComponent(
                                                    controller:
                                                        locationController,
                                                    hintText:
                                                        "Location: ${snapshot.data!.docs[index]['location']}",
                                                  ),
                                                  InputComponent(
                                                    controller: mallController,
                                                    hintText:
                                                        "Mall: ${snapshot.data!.docs[index]['mall']}",
                                                  ),
                                                  InputComponent(
                                                    controller:
                                                        unitNoController,
                                                    hintText:
                                                        "Unit No.: ${snapshot.data!.docs[index]['unit_no']}",
                                                  ),
                                                  InputComponent(
                                                    controller: emailController,
                                                    hintText:
                                                        "Email: ${snapshot.data!.docs[index]['email']}",
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      ButtonComponent(
                                                        color: Colors.green,
                                                        onTap: () {
                                                          snapshot
                                                              .data!
                                                              .docs[index]
                                                              .reference
                                                              .update({
                                                            "code": "2",
                                                            "email":
                                                                emailController
                                                                    .text,
                                                            "mall":
                                                                mallController
                                                                    .text,
                                                            "location":
                                                                locationController
                                                                    .text,
                                                            "restaurant":
                                                                restaurantNameController
                                                                    .text,
                                                            "unit_no":
                                                                unitNoController
                                                                    .text,
                                                          }).whenComplete(() =>
                                                                  Navigator.pop(
                                                                      context));
                                                        },
                                                        label: "Save",
                                                      ),
                                                      ButtonComponent(
                                                        color: Colors.red,
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        label: "Cancel",
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )),
                                        ));
                              },
                              blockLabel:
                                  snapshot.data!.docs[index]['code'] == "0"
                                      ? "Unblock"
                                      : "Block",
                              blockFunc: () {
                                if (snapshot.data!.docs[index]['code'] == "0") {
                                  snapshot.data!.docs[index].reference.update({
                                    "code": "2",
                                  });
                                } else {
                                  snapshot.data!.docs[index].reference.update({
                                    "code": "0",
                                  });
                                }
                              },
                              restaurant: snapshot.data!.docs[index]
                                  ['restaurant'],
                              mall: snapshot.data!.docs[index]['mall'],
                              location: snapshot.data!.docs[index]['location'],
                              email: snapshot.data!.docs[index]['email'],
                              unitNo: snapshot.data!.docs[index]['unit_no'],
                            ),
                          );
                        },
                      );
                    }
                    return const Text("No data available at the moment");
                  })
            ],
          ),
        ));
    ;
  }
}
