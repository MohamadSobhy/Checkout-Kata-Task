import '../enums/pricing_rule_type.dart';

/// A class to represent the pricing rule for a product.
/// The pricing rule can be of 4 types:
/// - [individual]: A single product with a fixed price
/// - [multiPriced]: A product with a fixed price when bought in a certain quantity
/// - [buyNGet1Free]: Buy N products and get 1 free
/// - [mealDeal]: A fixed price for a group of products
///
/// Each pricing rule will have the following properties:
/// - [type]: The type of the pricing rule to distinguish between the 4 types and to sort the pricing rules list with.
/// - [price]: The price of the product or the group of products.
/// - [quantity]: The quantity of the product to be bought to get the discount.
/// - [freeQuantity]: The quantity of the product to be free when bought in a certain quantity.
/// - [productCodes]: The list of product codes that the pricing rule will be applied to.
class PricingRule {
  final PricingRuleType type;
  final num price;
  final int quantity;
  final int freeQuantity;
  final List<String> productCodes;

  PricingRule.individual({
    required String productCode,
    required this.price,
  })  : type = PricingRuleType.individual,
        productCodes = [productCode],
        quantity = 1,
        freeQuantity = 0;

  PricingRule.multiPriced({
    required String productCode,
    required this.price,
    required this.quantity,
  })  : type = PricingRuleType.multiPriced,
        productCodes = [productCode],
        freeQuantity = 0;

  PricingRule.buyNGet1Free({
    required String productCode,
    required this.price,
    required this.quantity,
  })  : type = PricingRuleType.buyNGet1Free,
        productCodes = [productCode],
        freeQuantity = 1;

  PricingRule.mealDeal({
    required this.price,
    required this.productCodes,
  })  : type = PricingRuleType.mealDeal,
        quantity = 1,
        freeQuantity = 0;
}
