/// An emun to represent the type of each [Pricing Rule].
/// We have 4 types
/// - [individual]: A single product with a fixed price
/// - [multiPriced]: A product with a fixed price when bought in a certain quantity
/// - [buyNGet1Free]: Buy N products and get 1 free
/// - [mealDeal]: A fixed price for a group of products
///
/// [order] - The order of the pricing rule type to be used to sort the list of rules.
/// This will help to apply the offers rules first on the scanned products list.
/// And when all offers get applied to the products list, the individual pricing rules will be
/// applied to the remaining products.
enum PricingRuleType {
  individual(3),
  multiPriced(2),
  buyNGet1Free(1),
  mealDeal(0);

  final int order;

  const PricingRuleType(this.order);
}
