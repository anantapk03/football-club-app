import 'package:flutter/material.dart';

class HeaderTitleWidget extends StatelessWidget {
  final IconData? icon;
  final String? label;
  const HeaderTitleWidget({super.key, this.icon, this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          weight: 10.0,
          color: Colors.blue,
        ),
        const SizedBox(
          width: 5.0,
        ),
        Text(
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          label ?? "",
        ),
      ],
    );
  }
}
