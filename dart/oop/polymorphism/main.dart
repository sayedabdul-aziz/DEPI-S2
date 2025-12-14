import 'shape.dart';

void main() {
  Circle c = Circle(10);

  c.getArea();
  c.getPerimeter();

  Rectangle r = Rectangle(10, 20);

  calculateArea(c);
  calculateArea(r);
}

calculateArea(Area s) {
  s.getArea();
}

// paymentState: 'approved' // avoid magic numbers

enum PaymentState { pending, approved, rejected, completed, cancelled }

// paymentState: 2
// paymentState: PaymentState.approved
