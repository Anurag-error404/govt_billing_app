import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../constants/sizing.dart';

class SubmitButton extends StatelessWidget {
  final Function()? onTap;
  final String? txt;
  final Color? color;
  final double? paddingH;
  final IconData? icon;
  const SubmitButton({super.key, this.icon, this.onTap, this.txt, this.color, this.paddingH});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: paddingH ?? 50),
        decoration: BoxDecoration(
          color: color ?? primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              txt ?? "Submit",
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            if (icon != null) ...[
              horizontalSpaceSmall,
              Icon(
                icon,
                color: Colors.white,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
