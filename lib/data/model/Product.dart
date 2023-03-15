class Product {
  String? name;
  int quantity;
  int boxQuantity;
  int buyPrice;
  int sellPrice;
  int id;

  Product(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.boxQuantity,
      required this.buyPrice,
      required this.sellPrice});
}
