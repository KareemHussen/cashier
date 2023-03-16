class Product {
  int? id;
  String name;
  int quantity;
  int buyPrice;
  int sellPrice;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.buyPrice,
    required this.sellPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'buyPrice': buyPrice,
      'sellPrice': sellPrice,
      'id': id,
    };
  }
}