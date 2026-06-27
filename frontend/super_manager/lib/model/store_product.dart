//商品IDで取ってきた店のリストと値段を取るための型
class StoreProduct {
  final int storeId;
  final String storeName;
  final String location;
  final int productId;
  final int price;
  final int weight;
  StoreProduct({
    required this.storeId,
    required this.storeName,
    required this.location,
    required this.productId,
    required this.price,
    required this.weight,
  });

  factory StoreProduct.fromJson(Map<String, dynamic> json) {
    return StoreProduct(
      storeId: json['store_id'],
      storeName: json['store_mame'],
      location: json['location'],
      productId: json['product_id'],
      price: json['price'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'store_id': storeId,
      'store_name': storeName,
      'location': location,
      'product_id': productId,
      'price': price,
      'weight': weight,
    };
  }
}
