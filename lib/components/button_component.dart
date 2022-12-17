import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final Function()? onTap;
  final String? label;
  final Color? color;
  final double? buttonWidth;
  const ButtonComponent(
      {super.key, this.onTap, this.label, this.color, this.buttonWidth});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          width: buttonWidth ?? 100,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: color ?? Colors.amber),
          child: Text(
            label ?? "Button Label",
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          )),
    );
  }
}
