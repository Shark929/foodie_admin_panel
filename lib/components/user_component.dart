import 'package:flutter/material.dart';
import 'package:foodie_admin_panel/components/button_component.dart';

class UserComponent extends StatelessWidget {
  final String? email, phoneNum, userName;

  final Function()? blockFunc, deleteFunc, editFunc;
  const UserComponent(
      {super.key,
      this.deleteFunc,
      this.editFunc,
      this.blockFunc,
      this.email,
      this.phoneNum,
      this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.blueGrey),
      child: Row(
        children: [
          Row(
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
                  "assets/user.png",
                  width: 100.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Username: $userName",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Text(
                    "Email: $email",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Text(
                    "Phone: $phoneNum",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              ButtonComponent(
                label: "Edit",
                color: Colors.blue,
                onTap: editFunc,
              ),
              const SizedBox(
                width: 16,
              ),
              ButtonComponent(
                label: "Block",
                color: Colors.orange,
                onTap: blockFunc,
              ),
              const SizedBox(
                width: 16,
              ),
              ButtonComponent(
                label: "Delete",
                color: Colors.red,
                onTap: deleteFunc,
              ),
            ],
          )
        ],
      ),
    );
  }
}
