import 'package:flutter/material.dart';

void pushReplacement(BuildContext context, Widget newScreen) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => newScreen),
  );
}

void pushTo(BuildContext context, Widget newScreen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => newScreen));
}

void pushToBase(BuildContext context, Widget newScreen) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => newScreen),
    (route) => false,
  );
}

void pop(BuildContext context) {
  Navigator.pop(context);
}
