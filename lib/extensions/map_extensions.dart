extension MapExtensions on Map<String, int> {
  /// A getter to check if the products map contains any other products or not.
  /// The map will be emptyOrZers if the map has no items or all the items has quantity of 0.
  bool get isEmptyOrZeros => isEmpty || values.every((e) => e <= 0);
}
