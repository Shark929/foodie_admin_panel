import 'package:flutter/material.dart';
import 'package:foodie_admin_panel/components/home_component1.dart';

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
              children: const [
                HomeComponent1(
                    logo: "assets/sales.png", data: "RM 3,900,000.00"),
                HomeComponent1(logo: "assets/user.png", data: "650003"),
                HomeComponent1(logo: "assets/vendor.png", data: "34500"),
              ],
            ),
          ],
        ));
  }
}
