import 'package:flutter/material.dart';

class TransactionComponent extends StatelessWidget {
  final String transactionCode, amount, userEmail, details, time;
  const TransactionComponent(
      {super.key,
      required this.transactionCode,
      required this.amount,
      required this.userEmail,
      required this.details,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(children: [
        transactionCode == "1"
            ? Image.asset(
                "assets/top-up.png",
                height: 30,
                width: 30,
                color: Colors.blue,
              )
            : transactionCode == "2"
                ? Image.asset(
                    "assets/fast-food.png",
                    height: 30,
                    width: 30,
                    color: Colors.green,
                  )
                : Image.asset(
                    "assets/takeover.png",
                    height: 30,
                    width: 30,
                    color: Colors.red,
                  ),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              details,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            Text(
              time,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ),
          ],
        ),
        const Spacer(),
        Text(
          "RM $amount",
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ]),
    );
  }
}
