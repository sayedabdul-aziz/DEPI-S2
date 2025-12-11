import 'bank_account.dart';

void main() {
  BankAccount account = BankAccount(
    name: "Ahmed Ali",
    accountNumber: "781264912641084",
  );
  account.balance = 2000;
  account.deposit(-1000);
  account.deposit(1000);
  print("Balance is ${account.balance}");
}
