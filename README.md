A sample command-line application with an entrypoint in `bin/`, library code
in `lib/`, and example unit test in `test/`.


## Task Plan:

- Will create an enum to represent the type of each pricing rule.

- Eaching Pricing Rule type will have an order to be used to sort the pricing rules list to make the offers rules(multiPriced, buyNGet1Free, mealDeal) come first in the list to be applied first to the product list each time a new product is scanned.

- This needed to check if the list of the products has any offers first before applying the individual case. This will give the customer all the available discounts first and then the individual price will be applied to the remaining products.

- Iterate over the products map until the products map get empty(All the scanned products price is alculted.)

- Iterate over the ordered pricing rules. (Pricing rule is order to get the offer rules applied first before the individual rules).

- In each iteration we should check for the pricing rule type and apply the approprite logic for it.

- [MealDeal Ruel]: for this rule we should check that all the products of this deal exist in the products list. 
	- If exist: add the deal price to the total price and decrease the quantity of the products
    in the products list by 1.
	
    - If not: continue to the next pricing rule.

- [BuyNGet1Free Rule]: for this rule we should check that the total quantity of the product is greater than or equal to the pricing rule quantity `totalQuantity >= rule.quantity`.
    - If true: add the rule price to the total price and decrease the total quantity by the rule quanity and the free giveaway quantity. Repeat this step if the total quantity is greater than or equal to the rule quanity.
    
    - If not: continue to the next pricing rule.

- [MultiPriced Rule]: for this rule we should check if the total quantity is greatee than the rule quantity. 
    - If it is greater: Then we can divide the total quantity by the rule quantity to get the number offers that could be applied on that product. Then we should reset the total quantity of the product to the remaining quantity after calculating the price of all the offers.

    - If not: continue to the next rule.

- [Individual Rule]: for this rule we will multiply the total quantity by the product price to get the total price of that product and then add it to the total price. Then we should set the quantity of that prduct to be 0.

- At the end we should print the total price and do the calculation each time a new product is scanned.

## How to run the project:

- Download and install the [Dart SDK](https://dart.dev/get-dart) to setup the dart environtment.
- Download [VS Code](https://code.visualstudio.com/) Editor or any other application that supports [Dart] projects.
- Clone and open the project in [VS Code].
- To run the project you have to ways:
    - Using GUI: click on the `Run` tap and then select either `Start Debugging` of `Run without Debugging` option and VS Code will run the app and shows the result in the `Debug Consule` tab.
    - Using Terminal: open the Terminal window in VS Code or the default terminal wimdow in your OS and open the project directory in the terminal and execute the this command `dart bin/fluro_task.dart`.

