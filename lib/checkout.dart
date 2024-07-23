import 'models/pricing_rule.dart';

/// A class to represent the checkout process.
/// It takes the pricing rules list in constractor at the beginning of each checkout.
/// It has the following properties:
/// - [pricingRules]: The list of pricing rules to be applied to the scanned products.
/// - [_products]: A map to store the scanned products with their quantities.
///
/// And it has the following methods:
/// - [scan]: A method to scan a product and add it to the products map.
class Checkout {
  final List<PricingRule> pricingRules;
  final Map<String, int> _products = {};

  Checkout(this.pricingRules) {
    /// Sorting the pricing rules list by the order of the pricing rule type.
    /// This will help to apply the offers rules first on the scanned products list.
    pricingRules.sort((a, b) => a.type.order.compareTo(b.type.order));
  }

  void scan(String productCode) {
    _products.update(productCode, (value) => value + 1, ifAbsent: () => 1);
  }
}
