import 'enums/pricing_rule_type.dart';
import 'extensions/map_extensions.dart';
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

    /// Calculate the total price of the scanned products based on the pricing rules
    /// Each time a new product is scanned.
    print('Total Checkout: ${calculateTotalCheckoutPrice()}');
  }

  /// A method to scan a product and add it to the products map.
  void scan(String productCode) {
    _products.update(productCode, (value) => value + 1, ifAbsent: () => 1);
  }

  num calculateTotalCheckoutPrice() {
    num total = 0;

    final totalProducts = {..._products};

    while (!totalProducts.isEmptyOrZeros) {
      for (final rule in pricingRules) {
        if (totalProducts.isEmptyOrZeros) return total;

        int totalQuantity = totalProducts[rule.productCodes.first] ?? 0;

        print('Before: $totalProducts');

        switch (rule.type) {
          case PricingRuleType.mealDeal:
            final mealDealProducts = rule.productCodes;

            bool hasADeal = true;

            while (hasADeal) {
              for (final code in mealDealProducts) {
                if (!totalProducts.containsKey(code) ||
                    totalProducts[code]! <= 0) {
                  hasADeal = false;
                  break;
                }
              }

              if (hasADeal) {
                total += rule.price;

                for (final code in mealDealProducts) {
                  totalProducts[code] = totalProducts[code]! - 1;
                }
              }
            }

            break;
          case PricingRuleType.buyNGet1Free:
            while (totalQuantity >= rule.quantity) {
              total += rule.price * rule.quantity;
              totalQuantity -= rule.quantity + rule.freeQuantity;
            }

            totalProducts[rule.productCodes.first] = totalQuantity;

            break;
          case PricingRuleType.multiPriced:
            final offersCount = totalQuantity ~/ rule.quantity;

            if (offersCount > 0) {
              final remainingQuantity = totalQuantity % rule.quantity;
              total += offersCount * rule.price;
              totalProducts[rule.productCodes.first] = remainingQuantity;
            }
            break;
          case PricingRuleType.individual:
            total += rule.price * totalQuantity;
            totalProducts[rule.productCodes.first] = 0;
            break;
        }

        print('After: $totalProducts');
      }
    }

    return total;
  }
}
