import 'package:bmi_calculator/colors.dart';
import 'package:flutter/material.dart';
// BMI	Status
// < 18.5	Underweight
// 18.5 - 24.9	Healthy Weight
// 25.0 - 29.9	Overweight
// ≥ 30.0	Obese

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.result});

  final double result;

  Widget getClassification() {
    if (result < 18.5) {
      return Text(
        'Underweight',
        style: TextStyle(fontSize: 24, color: Colors.amberAccent),
      );
    } else if (result <= 24.9) {
      return Text(
        'Healthy Weight',
        style: TextStyle(fontSize: 24, color: Colors.greenAccent),
      );
    } else if (result <= 29.9) {
      return Text(
        'Overweight',
        style: TextStyle(fontSize: 24, color: Colors.orangeAccent),
      );
    } else {
      return Text(
        'Obese',
        style: TextStyle(fontSize: 24, color: Colors.redAccent),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'BMI Result',
          style: TextStyle(color: AppColors.whiteColor),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getClassification(),
            const SizedBox(height: 16),
            Text(
              'Your BMI is: ${result.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 24,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
