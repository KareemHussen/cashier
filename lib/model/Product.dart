class Product {
  String? name;
  String? price;
  int? quantity;
  int? boxQuantity;
  int? buyPrice;
  int? sellPrice;
  int? id;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.quantity,
      required this.boxQuantity,
      required this.buyPrice,
      required this.sellPrice});
}
