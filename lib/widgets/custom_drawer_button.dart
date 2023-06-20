import 'package:flutter/material.dart';

class CustomDrawerButton extends StatelessWidget {
  const CustomDrawerButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.selected,
  });

  final Icon icon;
  final String label;
  final VoidCallback onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      height: 60,
      elevation: 0,
      color: selected
          ? Colors.lightBlue.shade700.withOpacity(.6)
          : Colors.transparent,
      child: Row(
        children: [
          icon,
          const SizedBox(width: 20),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
