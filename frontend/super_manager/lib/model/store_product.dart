//商品IDで取ってきた店のリストと値段を取るための型
class StoreProduct {
  final int? id;
  final String storeName;
  final String productName;
  final String location;
  final int price;
  final int weight;
  StoreProduct({
    this.id,
    required this.storeName,
    required this.productName,
    required this.location,
    required this.price,
    required this.weight,
  });

  factory StoreProduct.fromJson(Map<String, dynamic> json) {
    return StoreProduct(
      id: json['id'] as int?,
      storeName: json['store_mame'],
      location: json['location'],
      productName: json['product_name'],
      price: json['price'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'store_name': storeName,
      'product_name': productName,
      'location': location,
      'price': price,
      'weight': weight,
    };
  }
}
