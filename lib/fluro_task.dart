import 'checkout.dart';
import 'models/pricing_rule.dart';

void calculateCheckoutKataSample() {
  final pricingRules = [
    PricingRule.individual(productCode: 'A', price: 0.50),
    PricingRule.individual(productCode: 'B', price: 0.75),
    PricingRule.individual(productCode: 'C', price: 0.25),
    PricingRule.individual(productCode: 'D', price: 1.5),
    PricingRule.individual(productCode: 'E', price: 2),
    PricingRule.multiPriced(quantity: 2, productCode: 'B', price: 1.25),
    PricingRule.buyNGet1Free(quantity: 3, productCode: 'C', price: 0.25),
    PricingRule.mealDeal(productCodes: ['D', 'E'], price: 3),
  ];

  final checkout = Checkout(pricingRules);

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
