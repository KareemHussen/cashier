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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      buyPrice: json['buyPrice'] as int,
      sellPrice: json['sellPrice'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'quantity': quantity,
    'buyPrice': buyPrice,
    'sellPrice': sellPrice,
  };


}