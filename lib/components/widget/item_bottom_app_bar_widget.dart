import 'package:flutter/material.dart';

class ItemBottomAppBarWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData? icon;
  final String? label;
  final TextStyle? style;
  final int? selectedItem;
  final int? value;
  const ItemBottomAppBarWidget(
      {super.key,
      this.icon,
      this.label,
      this.onTap,
      this.style,
      this.value,
      this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 5 - 16.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(
              height: 5,
            ),
            Text(
              label ?? "",
              textAlign: TextAlign.center,
              style: _currentTextStyle(selectedItem ?? 0, value ?? 0),
            )
          ],
        ),
      ),
    );
  }

  _currentTextStyle(int selectedItem, int value) {
    if (selectedItem == value) {
      return const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w500, color: Colors.purple);
    } else {
      return const TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 12,
      );
    }
  }
}
