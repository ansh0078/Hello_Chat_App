import 'package:flutter/material.dart';

class PrimaryBtn extends StatelessWidget {
  final String btnName;
  final IconData? icon;
  final VoidCallback ontap;
  final Color? color;
  const PrimaryBtn({
    super.key,
    required this.btnName,
    this.icon,
    required this.ontap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color ?? Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null ? Icon(icon) : const SizedBox(),
            const SizedBox(width: 10),
            Text(
              btnName,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
