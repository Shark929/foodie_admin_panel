import 'package:flutter/material.dart';
import 'package:foodie_admin_panel/components/button_component.dart';

class MenuComponent extends StatelessWidget {
  final String foodName, foodPrice, image;
  final Function()? editFunc, deleteFunc;
  const MenuComponent(
      {super.key,
      required this.foodName,
      required this.foodPrice,
      required this.image,
      this.editFunc,
      this.deleteFunc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 24, 148, 80),
      ),
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Row(
        children: [
          Container(
            height: 80,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover)),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  foodName,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text(
                  foodPrice,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ]),
          const Spacer(),
          ButtonComponent(
            onTap: editFunc,
            label: "Edit",
            color: Colors.blue,
          ),
          const SizedBox(
            width: 30,
          ),
          ButtonComponent(
            onTap: deleteFunc,
            label: "Delete",
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
