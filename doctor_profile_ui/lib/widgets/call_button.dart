import 'package:flutter/material.dart';

class CallButton extends StatelessWidget {
  const CallButton({super.key, required this.text, required this.onTap});

  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.indigoAccent.withValues(alpha: .4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(children: [Icon(Icons.call), Text(text)]),
      ),
    );
  }
}
