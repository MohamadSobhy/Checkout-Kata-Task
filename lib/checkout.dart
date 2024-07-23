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
  }

  /// A method to scan a product and add it to the products map.
  void scan(String productCode) {
    _products.update(productCode, (value) => value + 1, ifAbsent: () => 1);

    /// Calculate the total price of the scanned products based on the pricing rules
    /// Each time a new product is scanned.
    print('Total Checkout: ${calculateTotalCheckoutPrice()}');
  }

  /// A method to calculate the total price of the scanned products based on the pricing rules.
  num calculateTotalCheckoutPrice() {
    /// A variable to store the total price of the scanned products.
    num total = 0;

    /// Creates a copy of the scanned products map to avoid any changes on the original map.
    final totalProducts = {..._products};

    /// Iterate over the scanned products untill the products list get empty
    /// and the total price is calculated.
    while (!totalProducts.isEmptyOrZeros) {
      /// Iterate over the pricing rules list to apply the rules on the scanned products.
      /// The rules will be applied based on the order of the pricing rule type.
      /// [Offers Rules] will be applied first if exist then the [Individual Rules] will be applied.
      for (final rule in pricingRules) {
        /// Finish the loop and return the total price
        /// if the products list get empty before applying all the pricing list.
        /// Products list is empty means that the total price is calculated for all the
        /// scanned products so no need to continue applying the rest of pricing rules.
        if (totalProducts.isEmptyOrZeros) return total;

        /// Get the total quantity of the product code in the scanned products list.
        int totalQuantity = totalProducts[rule.productCodes.first] ?? 0;

        print('Before: $totalProducts');

        /// Apply the pricing rule logic based on the type of the rule.
        switch (rule.type) {
          case PricingRuleType.mealDeal:
            final mealDealProducts = rule.productCodes;

            bool hasADeal = true;

            while (hasADeal) {
              /// Checks if the deal products exist in the scanned products list or not.
              /// If not exist, then break the loop and stop applying the meal deal rule.
              for (final code in mealDealProducts) {
                if (!totalProducts.containsKey(code) ||
                    totalProducts[code]! <= 0) {
                  hasADeal = false;
                  break;
                }
              }

              /// If the deal products exist in the scanned products list,
              /// then apply the meal deal rule.
              if (hasADeal) {
                total += rule.price;

                /// Decrease the quantity of the deal products by 1 after applying the meal deal rule.
                for (final code in mealDealProducts) {
                  totalProducts[code] = totalProducts[code]! - 1;
                }
              }
            }

            break;
          case PricingRuleType.buyNGet1Free:

            /// Iterate while the total quantity of the product code
            /// is greater than the quantity of the rule.
            /// The rule will be applied on the product code based on the quantity of the rule.
            /// After applying the rule, decrease the total quantity of the product
            /// by the quantity of the rule and the free quantity.
            while (totalQuantity >= rule.quantity) {
              total += rule.price * rule.quantity;
              totalQuantity -= rule.quantity + rule.freeQuantity;
            }

            /// Reset the product quantity to the remaining quantity after applying the rule.
            totalProducts[rule.productCodes.first] = totalQuantity;

            break;
          case PricingRuleType.multiPriced:

            /// Calcualte how many offers of this rule could be applied to the product.
            final offersCount = totalQuantity ~/ rule.quantity;

            /// If there are offers of this rule could be applied to the product,
            /// then calculate the total price of the offers
            /// and reset the product quantity to the remaining quantity.
            if (offersCount > 0) {
              final remainingQuantity = totalQuantity % rule.quantity;
              total += offersCount * rule.price;
              totalProducts[rule.productCodes.first] = remainingQuantity;
            }
            break;
          case PricingRuleType.individual:

            /// Calculate the total price of the product based on the quantity of the product
            /// and reset the product quantity to 0.
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
