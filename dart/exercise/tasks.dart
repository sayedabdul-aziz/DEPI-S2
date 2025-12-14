void main() {
  print(reverse(543));
}

int reverse(int number) {
  int reversedNumber = 0; //34
  while (number != 0) {
    int reminder = number % 10; // 5
    reversedNumber = reversedNumber * 10 + reminder; // 345
    number ~/= 10;
  }

  return reversedNumber;
}

bool isLeapYear(int year) {
  if (year % 4 == 0) {
    if (year % 100 == 0) {
      if (year % 400 == 0) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  } else {
    return false;
  }
}
