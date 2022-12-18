import 'package:flutter/material.dart';

class HomeComponent1 extends StatelessWidget {
  final String logo, data, label;
  const HomeComponent1(
      {super.key, required this.logo, required this.data, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.blue),
            alignment: Alignment.center,
            child: Image.asset(
              logo,
              width: 100.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          )
        ],
      ),
      const SizedBox(
        width: 30,
      ),
      Text(
        data,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
    ]);
  }
}
