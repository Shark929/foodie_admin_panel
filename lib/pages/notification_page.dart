import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_admin_panel/components/new_vendor_component.dart';
import 'package:foodie_admin_panel/home.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
                "Notification",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 30,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("New_Vendor")
                      .snapshots(),
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
                            var data = snapshot.data!.docs[index];

                            return NewVendorComponent(
                              deleteFunc: () {
                                data.reference.delete().whenComplete(
                                      () => Navigator.pop(context),
                                    );
                              },
                              approveFunc: () {
                                FirebaseFirestore.instance
                                    .collection("Withdrawal")
                                    .add({
                                  "admin_commission": "0.00",
                                  "balance": "0.00",
                                  "current_withdrawal": "0.00",
                                  "time": "",
                                  "email": data['email'],
                                });
                                FirebaseFirestore.instance
                                    .collection("Location")
                                    .add({
                                  'image': "",
                                  "location": data['location'],
                                });
                                FirebaseFirestore.instance
                                    .collection("Mall")
                                    .add({
                                  'image': "",
                                  "location": data['location'],
                                  "mall_name": data['mall'],
                                });
                                // FirebaseFirestore.instance
                                //     .collection("Restaurants")
                                //     .add({
                                //   "code": "2",
                                //   "email": data['email'],
                                //   "food_category": "",
                                //   "food_description": "",
                                //   "food_name": "",
                                //   "image": "",
                                //   "location": data['location'],
                                //   "mall": data['mall'],
                                //   "price": "0.00",
                                // });
                                data.reference
                                    .update({"code": 2}).then((value) {
                                  FirebaseFirestore.instance
                                      .collection("Vendor")
                                      .add({
                                    "image":
                                        "https://i.picsum.photos/id/57/2448/3264.jpg?hmac=ewraXYesC6HuSEAJsg3Q80bXd1GyJTxekI05Xt9YjfQ",
                                    "password": data['password'],
                                    "restaurant": data['restaurant'],
                                    "location": data['location'],
                                    "mall": data['mall'],
                                    "unit_no": data['unit_no'],
                                    "code": "2",
                                    "email": data['email']
                                  }).then((value) {
                                    data.reference.delete().whenComplete(() =>
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyHomePage())));
                                  });
                                });
                              },
                              restaurant: data['restaurant'],
                              mall: data['mall'],
                              location: data['location'],
                              unitNo: data['unit_no'],
                              email: data['email'],
                            );
                          });
                    }
                    return Container(
                      color: Colors.white54,
                      padding: const EdgeInsets.all(16),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width - 300,
                    );
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
