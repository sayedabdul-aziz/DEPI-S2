class BankAccount {
  double _balance = 0;
  String name;
  String accountNumber;

  BankAccount({required this.name, required this.accountNumber});

  void deposit(double amount) {
    if (amount < 0) {
      print("Invalid amount");
    } else if (amount > 100000) {
      print("Deposit limit exceeded");
    } else {
      _balance += amount;
    }
  }

  void withdraw(double amount) {
    if (amount > _balance) {
      print("Insufficient balance");
    } else {
      _balance -= amount;
    }
  }

  double get balance => _balance;

  set balance(double amount) {
    _balance = amount;
  }
}
