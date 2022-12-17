import 'package:flutter/material.dart';

class NewVendorComponent extends StatelessWidget {
  final String? restaurant, mall, location, email, unitNo;
  final Function()? approveFunc, deleteFunc;

  const NewVendorComponent(
      {super.key,
      this.restaurant,
      this.mall,
      this.location,
      this.email,
      this.unitNo,
      this.approveFunc,
      this.deleteFunc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.yellow[400],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Restaurant: $restaurant",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              Text(
                "Location: $location",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              Text(
                "Mall: $mall",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              Text(
                "Unit No: $unitNo",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              Text(
                "Email: $email",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: approveFunc,
                  child: const Text(
                    "Approved",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  )),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Color.fromARGB(255, 168, 22, 11))),
                  onPressed: deleteFunc,
                  child: const Text(
                    "Deny",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
