import 'dart:io';

import 'checkout.dart';
import 'models/pricing_rule.dart';

final _defaultPricingRules = [
  PricingRule.individual(productCode: 'A', price: 0.50),
  PricingRule.individual(productCode: 'B', price: 0.75),
  PricingRule.individual(productCode: 'C', price: 0.25),
  PricingRule.individual(productCode: 'D', price: 1.5),
  PricingRule.individual(productCode: 'E', price: 2),
  PricingRule.multiPriced(quantity: 2, productCode: 'B', price: 1.25),
  PricingRule.buyNGet1Free(quantity: 3, productCode: 'C', price: 0.25),
  PricingRule.mealDeal(productCodes: ['D', 'E'], price: 3),
];

void calculateCheckoutKataSample() {
  final checkout = Checkout(_defaultPricingRules);

  checkout.scan('A');
  checkout.scan('B');
  checkout.scan('C');
  checkout.scan('D');
  checkout.scan('E');
  checkout.scan('A');
  checkout.scan('B');
  checkout.scan('A');
  checkout.scan('A');
  checkout.scan('E');
  checkout.scan('D');
  checkout.scan('C');
  checkout.scan('C');
  checkout.scan('C');
  checkout.scan('C');
}

void calculateCustomCheckoutKata() {
  while (true) {
    print("\n Select from the options:");
    print("1. Use defaule pricing rules.");
    print("2. Use custom pricing rules.");
    print("3. Exit.");

    final rulesChoice = stdin.readLineSync();

    late Checkout checkout;

    switch (rulesChoice) {
      case '1':
        checkout = Checkout(_defaultPricingRules);
        break;
      case '2':
        final pricingRules = <PricingRule>[];

        bool isRulesDone = false;

        while (!isRulesDone) {
          print("\nSelect pricing rules:");
          print("1. Individual pricing rule");
          print("2. Multi priced pricing rule");
          print("3. Buy N get 1 free pricing rule");
          print("4. Meal deal pricing rule");
          print("5. Done");

          final ruleChoice = stdin.readLineSync();

          switch (ruleChoice) {
            case '1':
              print("\nEnter product code:");
              final productCode = stdin.readLineSync()!.toUpperCase();

              print("Enter price:");
              final price = num.tryParse(stdin.readLineSync()!) ?? 0;

              pricingRules.add(
                PricingRule.individual(productCode: productCode, price: price),
              );
              break;
            case '2':
              print("\nEnter product code:");
              final productCode = stdin.readLineSync()!.toUpperCase();

              print("Enter price:");
              final price = num.tryParse(stdin.readLineSync()!) ?? 0;

              print("Enter quantity:");
              final quantity = int.tryParse(stdin.readLineSync()!) ?? 0;

              pricingRules.add(
                PricingRule.multiPriced(
                  productCode: productCode,
                  price: price,
                  quantity: quantity,
                ),
              );
              break;
            case '3':
              print("\nEnter product code:");
              final productCode = stdin.readLineSync()!.toUpperCase();

              print("Enter price:");
              final price = num.parse(stdin.readLineSync()!);

              print("Enter quantity:");
              final quantity = int.parse(stdin.readLineSync()!);

              pricingRules.add(
                PricingRule.buyNGet1Free(
                  productCode: productCode,
                  price: price,
                  quantity: quantity,
                ),
              );
              break;
            case '4':
              print("\nEnter product codes separated buy comma ',' :");
              final productCodes = stdin
                  .readLineSync()!
                  .split(',')
                  .map((e) => e.toUpperCase().trim())
                  .toList();

              print("Enter price:");
              final price = num.tryParse(stdin.readLineSync()!) ?? 0;

              pricingRules.add(
                PricingRule.mealDeal(productCodes: productCodes, price: price),
              );
              break;
            default:
              isRulesDone = true;
          }
        }

        checkout = Checkout(pricingRules);

      default:
        return;
    }

    print("\nStart Scanning products...");

    while (true) {
      print('\nSelect an option: ');
      print('1. Scan a product');
      print('2. Exit');

      final scanChoice = stdin.readLineSync();

      switch (scanChoice) {
        case '1':
          print("Enter product code:");
          final productCode = stdin.readLineSync()!;

          checkout.scan(productCode);
          break;
        case '2':
          return;
      }
    }
  }
}
