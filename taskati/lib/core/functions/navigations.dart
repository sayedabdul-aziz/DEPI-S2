import 'package:flutter/material.dart';

void pushTo(BuildContext context, Widget newScreen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => newScreen));
}

void pushReplacement(BuildContext context, Widget newScreen) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => newScreen),
  );
}

void pop(BuildContext context) {
  Navigator.pop(context);
}

extension NavigationExtension on BuildContext {
  void pushTo(Widget newScreen) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => newScreen));
  }
}



// context.pushTo(screen);
// pushTo(context, screen);