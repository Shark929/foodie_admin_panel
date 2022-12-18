import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_admin_panel/components/home_component1.dart';
import 'package:foodie_admin_panel/components/transaction_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                "Welcome Back Admin",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Withdrawal")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          double totalCommission = 0;
                          for (int i = 0; i < snapshot.data!.docs.length; i++) {
                            totalCommission += double.parse(
                                snapshot.data!.docs[i]['admin_commission']);
                          }
                          return HomeComponent1(
                              logo: "assets/commission.png",
                              data: "RM ${totalCommission.toStringAsFixed(2)}",
                              label: "Commission");
                        }
                        return const SizedBox();
                      }),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Order")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          double totalRevenueFromAllVendors = 0;

                          for (int i = 0; i < snapshot.data!.docs.length; i++) {
                            if (snapshot.data!.docs[i]['total_price'] != "0") {
                              totalRevenueFromAllVendors += double.parse(
                                  snapshot.data!.docs[i]['total_price']);
                            }
                          }
                          return HomeComponent1(
                              label: "Total Revenue",
                              logo: "assets/sales.png",
                              data:
                                  "RM ${totalRevenueFromAllVendors.toStringAsFixed(2)}");
                        }
                        return SizedBox();
                      }),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          return HomeComponent1(
                              label: "User",
                              logo: "assets/user.png",
                              data: snapshot.data!.docs.length.toString());
                        }
                        return SizedBox();
                      }),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Vendor")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          return HomeComponent1(
                              label: "Vendor",
                              logo: "assets/vendor.png",
                              data: snapshot.data!.docs.length.toString());
                        }
                        return SizedBox();
                      }),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Transactions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 16,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Transaction")
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
                            return TransactionComponent(
                                transactionCode: snapshot.data!.docs[index]
                                    ['payment_code'],
                                amount: snapshot.data!.docs[index]['amount'],
                                userEmail: snapshot.data!.docs[index]
                                    ['user_email'],
                                details: snapshot.data!.docs[index]
                                    ['food_name'],
                                time: snapshot.data!.docs[index]['time']);
                          });
                    }
                    return SizedBox();
                  })
            ],
          ),
        ));
  }
}
