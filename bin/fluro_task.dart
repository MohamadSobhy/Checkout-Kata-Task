import 'dart:io';

import 'package:fluro_task/fluro_task.dart' as fluro_task;

void main(List<String> arguments) {
  while (true) {
    print(
        '\n\n----------------------------------------------------------------');
    print("Fluro Checkout Kata");

    print("Please check from the following:");
    print("1. Calculate a sample example.");
    print("2. Calculate a custom example.");
    print("3. Exit.\n");

    final choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        fluro_task.calculateCheckoutKataSample();
        break;
      case '2':
        fluro_task.calculateCustomCheckoutKata();
        break;
      default:
        exit(0);
    }
  }
}
