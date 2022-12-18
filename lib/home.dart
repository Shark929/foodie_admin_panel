import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie_admin_panel/pages/category_page.dart';
import 'package:foodie_admin_panel/pages/home_page.dart';
import 'package:foodie_admin_panel/pages/notification_page.dart';
import 'package:foodie_admin_panel/pages/promo_page.dart';
import 'package:foodie_admin_panel/pages/user_page.dart';
import 'package:foodie_admin_panel/pages/vendor_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isUserNav = false;
  bool isVendorNav = false;
  bool isCategoryNav = false;
  bool isPromoNav = false;
  bool isNotificationNav = false;
  bool isHomeNav = true;

  CollectionReference newVendorRef =
      FirebaseFirestore.instance.collection("New_Vendor");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: 300,
                color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isHomeNav = true;
                          isNotificationNav = false;
                          isUserNav = false;
                          isVendorNav = false;
                          isCategoryNav = false;
                          isPromoNav = false;
                        });
                      },
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.red),
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/fork.png",
                              width: 100.0,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            "Foodie",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isNotificationNav = true;
                          isUserNav = false;
                          isVendorNav = false;
                          isCategoryNav = false;
                          isPromoNav = false;
                          isHomeNav = false;
                        });
                      },
                      child: Container(
                        width: 250,
                        height: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.amberAccent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Notification",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            StreamBuilder(
                              stream: newVendorRef.snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const SizedBox();
                                }
                                if (snapshot.data!.docs.isNotEmpty) {
                                  return Container(
                                    width: 30,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red),
                                    child: Text(
                                      snapshot.data!.docs.length.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }
                                if (snapshot.data!.docs.isEmpty) {
                                  return const SizedBox();
                                }
                                return const SizedBox();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isHomeNav = false;
                          isNotificationNav = false;
                          isUserNav = true;
                          isVendorNav = false;
                          isCategoryNav = false;
                          isPromoNav = false;
                        });
                      },
                      child: Container(
                        width: 250,
                        height: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.amberAccent,
                        ),
                        child: const Text(
                          "Users",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isHomeNav = false;

                          isNotificationNav = false;
                          isUserNav = false;
                          isVendorNav = true;
                          isCategoryNav = false;
                          isPromoNav = false;
                        });
                      },
                      child: Container(
                        width: 250,
                        height: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.amberAccent,
                        ),
                        child: const Text(
                          "Vendors",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //promo
                    InkWell(
                      onTap: () {
                        setState(() {
                          isHomeNav = false;
                          isNotificationNav = false;
                          isUserNav = false;
                          isVendorNav = false;
                          isCategoryNav = false;
                          isPromoNav = true;
                        });
                      },
                      child: Container(
                        width: 250,
                        height: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.amberAccent,
                        ),
                        child: const Text(
                          "Promo",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //Categort
                    InkWell(
                      onTap: () {
                        setState(() {
                          isHomeNav = false;
                          isNotificationNav = false;
                          isUserNav = false;
                          isVendorNav = false;
                          isCategoryNav = true;
                          isPromoNav = false;
                        });
                      },
                      child: Container(
                        width: 250,
                        height: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.amberAccent,
                        ),
                        child: const Text(
                          "Food Category",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 300),
                child: isHomeNav
                    ? const HomePage()
                    : isNotificationNav
                        ? const NotificationPage()
                        : isUserNav
                            ? const UserPage()
                            : isVendorNav
                                ? const VendorPage()
                                : isPromoNav
                                    ? const PromoPage()
                                    : isCategoryNav
                                        ? const CategoryPage()
                                        : Container()),
          ],
        ),
      ),
    );
  }
}
