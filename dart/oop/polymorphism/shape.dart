import 'dart:math';

abstract class Area {
  void getArea();
}

mixin Perimeter {
  void getPerimeter();
  startAnimation() {
    // start animation
  }
}

class Circle extends Area with Perimeter {
  int radius;

  Circle(this.radius);

  @override
  void getArea() {
    print("Area of circle: ${pi * radius * radius}");
  }

  @override
  void getPerimeter() {
    print("Perimeter of circle: ${2 * pi * radius}");
  }
}

class Rectangle extends Area {
  int width;
  int height;

  Rectangle(this.width, this.height);

  @override
  void getArea() {
    print("Area of rectangle: ${width * height}");
  }
}
